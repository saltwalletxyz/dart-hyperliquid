import 'package:hyperliquid/hyperliquid.dart';
import 'package:logger/logger.dart';

// Simple console example that fetches mids from testnet.
Future<void> main() async {
  final client = Hyperliquid(const HyperliquidConfig(testnet: true));
  await client.connect();
  final mids = await client.info.generalAPI.getAllMids();
  final logger = Logger();
  logger.i('Fetched ${mids.mids.length} mids');
  client.disconnect();
}
