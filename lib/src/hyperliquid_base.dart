import 'dart:async';

import 'package:logger/logger.dart';

import 'constants.dart';
import 'error/error_handler.dart';
import 'logging/structured_logger.dart';
import 'rest/custom_operations.dart';
import 'rest/exchange_api.dart';
import 'rest/info_api.dart';
import 'security/security_manager.dart';
import 'security/security_validator.dart';
import 'utils/rate_limiter.dart';
import 'utils/signing.dart';
import 'utils/symbol_conversion.dart';
import 'websocket/payload_generator.dart';
import 'websocket/payload_manager.dart';
import 'websocket/subscriptions.dart';
import 'websocket/websocket_client.dart';

/// Configuration options for the Hyperliquid SDK
class HyperliquidConfig {
  const HyperliquidConfig({
    this.enableWs = true,
    this.privateKey,
    this.testnet = false,
    this.walletAddress,
    this.vaultAddress,
    this.maxReconnectAttempts = 5,
    this.disableAssetMapRefresh = false,
    this.assetMapRefreshIntervalMs = 60000,
  });

  final bool enableWs;
  final String? privateKey;
  final bool testnet;
  final String? walletAddress;
  final String? vaultAddress;
  final int maxReconnectAttempts;
  final bool disableAssetMapRefresh;
  final int assetMapRefreshIntervalMs;
}

/// Main Hyperliquid SDK class
class Hyperliquid {
  Hyperliquid([HyperliquidConfig params = const HyperliquidConfig()])
      : testnet = params.testnet,
        baseUrl = params.testnet ? BaseUrls.testnet : BaseUrls.production,
        enableWs = params.enableWs {
    rateLimiter = RateLimiter();

    // Initialize logging and error handling
    structuredLogger = StructuredLogger(
      serviceName: 'hyperliquid-dart-sdk',
      version: '1.0.0',
      logLevel: Level.info,
      enableStructuredOutput: true,
    );

    errorHandler = ErrorHandler(
      enableAutoRecovery: true,
      maxRetryAttempts: 3,
      baseRetryDelay: const Duration(seconds: 1),
    );

    security = SecurityManager(
      strictValidation: true,
      logSecurityEvents: true,
      enableRateLimiting: true,
    );
    symbolConversion = SymbolConversion(
      baseUrl,
      rateLimiter,
      params.disableAssetMapRefresh,
      params.assetMapRefreshIntervalMs,
    );
    walletAddress = params.walletAddress;
    vaultAddress = params.vaultAddress;

    // Initialize REST API clients
    info = InfoAPI(baseUrl, rateLimiter, symbolConversion, this);

    // Initialize WebSocket client if enabled
    if (enableWs) {
      ws = WebSocketClient(testnet, params.maxReconnectAttempts);
      subscriptions = WebSocketSubscriptions(ws, symbolConversion);
    }

    // Set up authentication if private key is provided
    if (params.privateKey != null) {
      _initializeWithPrivateKey(params.privateKey!, testnet);
    } else if (params.walletAddress != null) {
      _walletAddress = params.walletAddress;
      walletAddress = params.walletAddress;
    }
  }

  Future<void> connect() async {
    if (!_initialized) {
      _initializing ??= _initialize();
      await _initializing;
    }
  }

  Future<void> _initialize() async {
    if (_initialized) return;

    try {
      // Connect WebSocket if enabled
      if (enableWs) {
        try {
          await ws.connect();
        } catch (wsError) {
          _logger.w('Failed to establish WebSocket connection: $wsError');
        }
      }

      _initialized = true;
      _initializing = null;
    } catch (error) {
      _initializing = null;
      rethrow;
    }
  }

  // Configuration
  final bool testnet;
  final String baseUrl;
  final bool enableWs;

  // Core components
  late InfoAPI info;
  late ExchangeAPI exchange;
  late CustomOperations custom;
  late WebSocketClient ws;
  late WebSocketSubscriptions subscriptions;
  late WebSocketPayloadManager wsPayloads;
  late SymbolConversion symbolConversion;
  late SecurityManager security;
  late ErrorHandler errorHandler;
  late StructuredLogger structuredLogger;
  late RateLimiter rateLimiter;

  // Authentication
  String? walletAddress;
  String? vaultAddress;
  // ignore: unused_field
  String? _privateKey;
  // ignore: unused_field
  String? _walletAddress;
  bool isValidPrivateKey = false;

  // Initialization state
  bool _initialized = false;
  Future<void>? _initializing;

  // Logger
  final Logger _logger = Logger(
    printer: PrettyPrinter(methodCount: 0, noBoxingByDefault: true),
  );

  Future<void> ensureInitialized() async {
    await connect();
  }

  void _initializeWithPrivateKey(String privateKey, [bool testnet = false]) {
    try {
      // Validate private key with security checks (synchronous for now)
      final validationResult = SecurityValidator.validatePrivateKey(privateKey);
      if (!validationResult.isValid) {
        throw Exception('Private key validation failed: ${validationResult.message}');
      }

      // Derive wallet address
      final wallet = Wallet(privateKey);
      walletAddress = wallet.address.hex;

      isValidPrivateKey = true;
      _privateKey = privateKey;

      if (isValidPrivateKey) {
        exchange = ExchangeAPI(
          testnet,
          privateKey,
          info,
          rateLimiter,
          symbolConversion,
          walletAddress,
          this,
          vaultAddress,
        );

        // Initialize custom operations
        custom = CustomOperations(
          this,
          exchange,
          info,
          symbolConversion,
          walletAddress,
        );

        // Initialize WebSocket payload manager if WebSocket is enabled
        if (enableWs) {
          final wallet = Wallet(privateKey);
          final payloadGenerator = PayloadGenerator(
            PayloadGeneratorContext(
              wallet: wallet,
              isMainnet: !testnet,
              symbolConversion: symbolConversion,
              vaultAddress: vaultAddress,
              generateNonce: () => DateTime.now().millisecondsSinceEpoch,
            ),
          );

          wsPayloads = WebSocketPayloadManager(
            payloadGenerator: payloadGenerator,
            subscriptions: subscriptions,
            customOperations: custom,
            vaultAddress: vaultAddress,
          );
        }
      }
    } catch (error) {
      _logger.w('Invalid private key provided. Some functionalities will be limited.');
      isValidPrivateKey = false;
    }
  }

  bool isAuthenticated() {
    ensureInitialized();
    return isValidPrivateKey;
  }

  bool isWebSocketConnected() {
    if (!enableWs) return false;
    return ws.isConnected();
  }

  void disconnect() {
    try {
      structuredLogger.info('Disconnecting from Hyperliquid', {
        'authenticated': isAuthenticated(),
        'websocketEnabled': enableWs,
      });

      // Stop the asset map refresh interval
      symbolConversion.stopPeriodicRefresh();

      // Close WebSocket connection if enabled
      if (enableWs) {
        ws.close(true); // Pass true to indicate manual disconnect
        subscriptions.disconnect();
      }

      // Clean up logging resources
      structuredLogger.close();

      // Reset initialization state
      _initialized = false;
      _initializing = null;

      structuredLogger.info('Successfully disconnected from Hyperliquid');
    } catch (e, stackTrace) {
      errorHandler.logError('disconnect', e, stackTrace);
    }
  }

  String getBaseUrl() {
    return baseUrl;
  }

  RateLimiter getRateLimiter() {
    return rateLimiter;
  }

  // Asset map refresh control methods
  void enableAssetMapRefresh() {
    symbolConversion.enablePeriodicRefresh();
  }

  void disableAssetMapRefresh() {
    symbolConversion.disablePeriodicRefresh();
  }

  bool isAssetMapRefreshEnabled() {
    return symbolConversion.isRefreshEnabled();
  }

  int getAssetMapRefreshInterval() {
    return symbolConversion.getRefreshInterval();
  }

  void setAssetMapRefreshInterval(int intervalMs) {
    symbolConversion.setRefreshInterval(intervalMs);
  }

  Future<void> refreshAssetMapsNow() async {
    await symbolConversion.initialize();
  }
}
