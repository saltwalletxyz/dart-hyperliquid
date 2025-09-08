/// Flutter Integration Example for Hyperliquid Dart SDK
///
/// This example demonstrates how to integrate the Hyperliquid SDK
/// into a Flutter application for mobile trading.
///
/// Features covered:
/// - Secure private key storage
/// - Real-time price updates
/// - Quick trading interface
/// - Portfolio monitoring
/// - Push notifications
///
/// To use this example:
/// 1. Add flutter_secure_storage to pubspec.yaml
/// 2. Add flutter_local_notifications to pubspec.yaml
/// 3. Configure notification permissions
/// 4. Replace placeholder private key with secure storage implementation
library;

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hyperliquid/hyperliquid.dart';

void main() {
  runApp(HyperliquidTradingApp());
}

class HyperliquidTradingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hyperliquid Trading',
      theme: ThemeData.dark().copyWith(
        primarySwatch: Colors.blue,
        accentColor: Colors.green,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Hyperliquid client;
  bool isLoading = true;
  String statusMessage = 'Initializing...';

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  Future<void> initializeApp() async {
    try {
      setState(() => statusMessage = 'Loading secure credentials...');

      final privateKey = await getSecurePrivateKey();
      if (privateKey.isEmpty) {
        // Show setup screen if no private key
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => SetupScreen()),
        );
        return;
      }

      setState(() => statusMessage = 'Connecting to Hyperliquid...');

      client = Hyperliquid(HyperliquidConfig(
        testnet: true, // Always use testnet for examples
        privateKey: privateKey,
        enableWs: true,
        maxReconnectAttempts: 5,
      ));

      await client.connect();

      setState(() => statusMessage = 'Setting up real-time data...');

      // Verify connection and authentication
      if (!client.isAuthenticated()) {
        throw Exception('Authentication failed');
      }

      // Navigate to main app
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MainTradingScreen(client: client),
        ),
      );
    } catch (e) {
      setState(() {
        statusMessage = 'Connection failed: $e';
        isLoading = false;
      });
    }
  }

  Future<String> getSecurePrivateKey() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'hyperliquid_private_key') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo/icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.trending_up,
                size: 50,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 32),

            Text(
              'Hyperliquid Trading',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 16),

            if (isLoading) ...[
              CircularProgressIndicator(),
              SizedBox(height: 16),
            ],

            Text(
              statusMessage,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[400],
              ),
              textAlign: TextAlign.center,
            ),

            if (!isLoading)
              ElevatedButton(
                onPressed: () {
                  setState(() => isLoading = true);
                  initializeApp();
                },
                child: Text('Retry'),
              ),
          ],
        ),
      ),
    );
  }
}

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final _privateKeyController = TextEditingController();
  bool _isTestnet = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setup Hyperliquid'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Hyperliquid Trading',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'To get started, enter your private key. This will be stored securely on your device.',
              style: TextStyle(color: Colors.grey[400]),
            ),
            SizedBox(height: 32),
            TextFormField(
              controller: _privateKeyController,
              decoration: InputDecoration(
                labelText: 'Private Key',
                hintText: '0x...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.key),
              ),
              obscureText: true,
              maxLines: 1,
            ),
            SizedBox(height: 16),
            SwitchListTile(
              title: Text('Testnet Mode'),
              subtitle: Text('Recommended for testing'),
              value: _isTestnet,
              onChanged: (value) => setState(() => _isTestnet = value),
            ),
            SizedBox(height: 32),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning, color: Colors.orange),
                      SizedBox(width: 8),
                      Text(
                        'Security Notice',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '• Never share your private key\n'
                    '• Use testnet for learning\n'
                    '• Only use mainnet with small amounts initially\n'
                    '• This app stores keys locally with encryption',
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveAndContinue,
                child: _isLoading ? CircularProgressIndicator() : Text('Save & Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveAndContinue() async {
    final privateKey = _privateKeyController.text.trim();

    if (privateKey.isEmpty || !privateKey.startsWith('0x')) {
      _showErrorDialog('Please enter a valid private key starting with 0x');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Test the private key
      final testClient = Hyperliquid(HyperliquidConfig(
        testnet: _isTestnet,
        privateKey: privateKey,
        enableWs: false, // Quick test without WebSocket
      ));

      await testClient.connect();

      if (!testClient.isAuthenticated()) {
        throw Exception('Invalid private key');
      }

      testClient.disconnect();

      // Save securely
      const storage = FlutterSecureStorage();
      await storage.write(key: 'hyperliquid_private_key', value: privateKey);
      await storage.write(key: 'hyperliquid_testnet', value: _isTestnet.toString());

      // Navigate to main app
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SplashScreen()),
      );
    } catch (e) {
      _showErrorDialog('Failed to connect: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

class MainTradingScreen extends StatefulWidget {

  MainTradingScreen({required this.client});
  final Hyperliquid client;

  @override
  _MainTradingScreenState createState() => _MainTradingScreenState();
}

class _MainTradingScreenState extends State<MainTradingScreen> {
  int _currentIndex = 0;
  final Map<String, double> _prices = {};
  Map<String, dynamic> _portfolio = {};

  final List<String> _watchedSymbols = ['BTC-PERP', 'ETH-PERP', 'SOL-PERP', 'AVAX-PERP', 'MATIC-PERP'];

  @override
  void initState() {
    super.initState();
    _setupRealtimeData();
    _loadInitialData();
  }

  void _setupRealtimeData() {
    // Subscribe to real-time price updates
    widget.client.subscriptions.subscribeToAllMids();

    widget.client.subscriptions.onAllMids((data) {
      setState(() {
        for (final symbol in _watchedSymbols) {
          final price = data.mids[symbol];
          if (price != null) {
            _prices[symbol] = double.parse(price);
          }
        }
      });
    });

    // Subscribe to user events for notifications
    widget.client.subscriptions.subscribeToUserEvents();
    widget.client.subscriptions.onUserEvents((events) {
      for (final event in events) {
        _handleUserEvent(event);
      }
    });
  }

  Future<void> _loadInitialData() async {
    try {
      // Load portfolio data
      final userState = await widget.client.info.getUserState(widget.client.address);

      double totalUnrealizedPnl = 0;
      int openPositions = 0;

      for (final pos in userState.assetPositions) {
        if (pos.position.szi != '0') {
          openPositions++;
          totalUnrealizedPnl += double.parse(pos.position.unrealizedPnl);
        }
      }

      setState(() {
        _portfolio = {
          'equity': double.parse(userState.marginSummary.accountValue),
          'unrealizedPnl': totalUnrealizedPnl,
          'openPositions': openPositions,
          'availableBalance':
              double.parse(userState.marginSummary.accountValue) - double.parse(userState.marginSummary.totalMarginUsed),
        };
      });
    } catch (e) {
      print('Failed to load portfolio: $e');
    }
  }

  void _handleUserEvent(dynamic event) {
    // Handle different types of user events
    switch (event.type) {
      case 'fill':
        _showNotification('Order Filled', 'Your ${event.data['coin']} order has been filled');
        break;
      case 'liquidation':
        _showNotification(
          'Position Liquidated',
          'Your ${event.data['coin']} position has been liquidated',
          isWarning: true,
        );
        break;
    }
  }

  void _showNotification(String title, String body, {bool isWarning = false}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              isWarning ? Icons.warning : Icons.check_circle,
              color: isWarning ? Colors.orange : Colors.green,
            ),
            SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: Text(body),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          DashboardTab(
            client: widget.client,
            portfolio: _portfolio,
            prices: _prices,
            watchedSymbols: _watchedSymbols,
            onRefresh: _loadInitialData,
          ),
          TradingTab(client: widget.client),
          PortfolioTab(client: widget.client, portfolio: _portfolio),
          MarketsTab(prices: _prices, watchedSymbols: _watchedSymbols),
          SettingsTab(client: widget.client),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Trade',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Markets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.client.disconnect();
    super.dispose();
  }
}

// Dashboard Tab
class DashboardTab extends StatelessWidget {

  DashboardTab({
    required this.client,
    required this.portfolio,
    required this.prices,
    required this.watchedSymbols,
    required this.onRefresh,
  });
  final Hyperliquid client;
  final Map<String, dynamic> portfolio;
  final Map<String, double> prices;
  final List<String> watchedSymbols;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Portfolio summary card
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Portfolio Summary',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _portfolioMetric(
                          'Total Equity',
                          '\$${(portfolio['equity'] ?? 0.0).toStringAsFixed(2)}',
                          Colors.blue,
                        ),
                      ),
                      Expanded(
                        child: _portfolioMetric(
                          'Unrealized PnL',
                          '\$${(portfolio['unrealizedPnl'] ?? 0.0).toStringAsFixed(2)}',
                          (portfolio['unrealizedPnl'] ?? 0.0) >= 0 ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _portfolioMetric(
                          'Open Positions',
                          '${portfolio['openPositions'] ?? 0}',
                          Colors.orange,
                        ),
                      ),
                      Expanded(
                        child: _portfolioMetric(
                          'Available Balance',
                          '\$${(portfolio['availableBalance'] ?? 0.0).toStringAsFixed(2)}',
                          Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16),

          // Price ticker
          Text(
            'Market Prices',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: watchedSymbols.length,
              itemBuilder: (context, index) {
                final symbol = watchedSymbols[index];
                final price = prices[symbol] ?? 0.0;

                return Container(
                  width: 120,
                  margin: EdgeInsets.only(right: 8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[700]!),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        symbol.replaceAll('-PERP', ''),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '\$${price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 16),

          // Quick actions
          Text(
            'Quick Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to trading tab
                  },
                  icon: Icon(Icons.add),
                  label: Text('New Order'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    // Close all positions
                    try {
                      await client.custom.closeAllPositions(slippage: 0.05);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('All positions closed')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to close positions: $e')),
                      );
                    }
                  },
                  icon: Icon(Icons.close),
                  label: Text('Close All'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _portfolioMetric(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[400]),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

// Trading Tab
class TradingTab extends StatefulWidget {

  TradingTab({required this.client});
  final Hyperliquid client;

  @override
  _TradingTabState createState() => _TradingTabState();
}

class _TradingTabState extends State<TradingTab> {
  String _selectedSymbol = 'BTC-PERP';
  double _size = 0.001;
  double? _limitPrice;
  bool _isBuy = true;
  bool _isMarketOrder = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Trade',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 24),

          // Symbol selector
          DropdownButtonFormField<String>(
            value: _selectedSymbol,
            decoration: InputDecoration(
              labelText: 'Symbol',
              border: OutlineInputBorder(),
            ),
            items: ['BTC-PERP', 'ETH-PERP', 'SOL-PERP', 'AVAX-PERP', 'MATIC-PERP']
                .map((symbol) => DropdownMenuItem(
                      value: symbol,
                      child: Text(symbol),
                    ))
                .toList(),
            onChanged: (value) => setState(() => _selectedSymbol = value!),
          ),

          SizedBox(height: 16),

          // Buy/Sell toggle
          Container(
            width: double.infinity,
            child: ToggleButtons(
              isSelected: [_isBuy, !_isBuy],
              onPressed: (index) => setState(() => _isBuy = index == 0),
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width - 48) / 2,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('BUY', textAlign: TextAlign.center),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width - 48) / 2,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('SELL', textAlign: TextAlign.center),
                ),
              ],
              selectedColor: Colors.white,
              fillColor: _isBuy ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
          ),

          SizedBox(height: 16),

          // Order type
          SwitchListTile(
            title: Text('Market Order'),
            subtitle: Text(_isMarketOrder ? 'Execute immediately' : 'Set limit price'),
            value: _isMarketOrder,
            onChanged: (value) => setState(() => _isMarketOrder = value),
          ),

          SizedBox(height: 16),

          // Size input
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Size',
              border: OutlineInputBorder(),
              suffixText: 'contracts',
            ),
            keyboardType: TextInputType.number,
            initialValue: _size.toString(),
            onChanged: (value) => _size = double.tryParse(value) ?? _size,
          ),

          if (!_isMarketOrder) ...[
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Limit Price',
                border: OutlineInputBorder(),
                suffixText: 'USD',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => _limitPrice = double.tryParse(value),
            ),
          ],

          Spacer(),

          // Execute button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _executeOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isBuy ? Colors.green : Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                      '${_isBuy ? 'BUY' : 'SELL'} $_selectedSymbol',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _executeOrder() async {
    setState(() => _isLoading = true);

    try {
      if (_isMarketOrder) {
        // Market order
        await widget.client.custom.marketOpen(
          _selectedSymbol,
          _isBuy,
          _size,
          slippage: 0.02,
        );
      } else {
        // Limit order
        if (_limitPrice == null) {
          throw Exception('Limit price is required');
        }

        await widget.client.exchange.placeOrder({
          'coin': _selectedSymbol,
          'is_buy': _isBuy,
          'sz': _size,
          'limit_px': _limitPrice!,
          'order_type': {
            'limit': {'tif': 'Gtc'}
          },
          'reduce_only': false,
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order executed successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}

// Portfolio Tab
class PortfolioTab extends StatelessWidget {

  PortfolioTab({required this.client, required this.portfolio});
  final Hyperliquid client;
  final Map<String, dynamic> portfolio;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text(
          'Portfolio',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 16),

        // Portfolio metrics
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _portfolioRow('Total Equity', '\$${(portfolio['equity'] ?? 0.0).toStringAsFixed(2)}'),
                _portfolioRow('Unrealized PnL', '\$${(portfolio['unrealizedPnl'] ?? 0.0).toStringAsFixed(2)}'),
                _portfolioRow('Available Balance', '\$${(portfolio['availableBalance'] ?? 0.0).toStringAsFixed(2)}'),
                _portfolioRow('Open Positions', '${portfolio['openPositions'] ?? 0}'),
              ],
            ),
          ),
        ),

        SizedBox(height: 16),

        // Positions list
        Text(
          'Open Positions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 8),

        // Placeholder for positions
        Card(
          child: ListTile(
            title: Text('No open positions'),
            subtitle: Text('Your positions will appear here'),
            leading: Icon(Icons.info_outline),
          ),
        ),
      ],
    );
  }

  Widget _portfolioRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// Markets Tab
class MarketsTab extends StatelessWidget {

  MarketsTab({required this.prices, required this.watchedSymbols});
  final Map<String, double> prices;
  final List<String> watchedSymbols;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text(
          'Markets',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        ...watchedSymbols.map((symbol) {
          final price = prices[symbol] ?? 0.0;
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text(symbol.split('-')[0].substring(0, 2)),
              ),
              title: Text(symbol),
              subtitle: Text('Perpetual'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '24h: +0.00%',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

// Settings Tab
class SettingsTab extends StatelessWidget {

  SettingsTab({required this.client});
  final Hyperliquid client;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text(
          'Settings',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Account'),
                subtitle: Text(client.address.substring(0, 10) + '...'),
                trailing: Icon(Icons.chevron_right),
              ),
              Divider(height: 1),
              ListTile(
                leading: Icon(Icons.security),
                title: Text('Security'),
                subtitle: Text('Private key management'),
                trailing: Icon(Icons.chevron_right),
              ),
              Divider(height: 1),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notifications'),
                subtitle: Text('Trading alerts'),
                trailing: Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.help),
                title: Text('Help & Support'),
                trailing: Icon(Icons.chevron_right),
              ),
              Divider(height: 1),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                trailing: Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
        SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            // Logout functionality
            _showLogoutDialog(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: Text('Logout'),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Clear stored credentials
              const storage = FlutterSecureStorage();
              storage.deleteAll();

              // Navigate to setup
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => SetupScreen()),
                (route) => false,
              );
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
