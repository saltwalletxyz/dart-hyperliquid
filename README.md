<div align="center">

# hyperliquid

**Hyperliquid Dart SDK – REST, WebSocket & trading utilities for perpetuals and spot**

[![Pub Version](https://img.shields.io/pub/v/hyperliquid?label=pub.dev)](https://pub.dev/packages/hyperliquid)
[![Dart SDK](https://img.shields.io/badge/dart-%3E=3.0.0-blue)](https://dart.dev)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

</div>

## Overview

This package provides a strongly-typed, ergonomic Dart interface for the **Hyperliquid** exchange APIs.

It currently focuses on:

- Info (public) REST endpoints (general, spot, perpetuals)
- Trading / account actions (order placement, cancels, leverage updates, transfers, vault ops, etc.)
- Deterministic nonce handling for sequential L1 actions
- Symbol ↔ asset index conversion and periodic asset map refreshing
- Basic WebSocket bootstrap (future real-time subscriptions layer)

> Status: Early preview (`0.0.x`). API surface may still evolve. Feedback & issues welcome.

## Features

- Unified `Hyperliquid` client for testnet & mainnet
- Batched order placement & modification helpers
- TWAP order creation / cancellation
- Vault: create, modify, transfer, distribute
- Spot & USD class transfers, internal sub-account transfers
- Builder / agent approvals, referral, reward claims
- Rich info queries: order book (L2), candles, fills, order status, user rate limits, delegations, vaults & more
- Typed deserialization with `freezed` & `json_serializable`
- Rate limiter utility scaffold (pluggable for client–side fairness)

## Installation

Add to `pubspec.yaml`:

```yaml
dependencies:
	hyperliquid: ^0.0.1
```

Then run:

```sh
dart pub get
```

## Quick Start

```dart
import 'package:hyperliquid/hyperliquid.dart';

Future<void> main() async {
	// Testnet client (no private key = public/info only)
	final client = Hyperliquid(const HyperliquidConfig(testnet: true));
	await client.connect();

	final mids = await client.info.getAllMids();
	print('Fetched ${mids.mids.length} mids');

	client.disconnect();
}
```

## Authentication & Trading

Pass a private key (hex string) to enable trading actions:

```dart
final trader = Hyperliquid(const HyperliquidConfig(
	testnet: true,
	privateKey: '0xYOUR_PRIVATE_KEY',
));
await trader.connect();

// Simple limit order example
final order = {
	'coin': 'BTC',            // Exchange symbol
	'is_buy': true,           // true = bid, false = ask
	'sz': 0.001,              // size
	'px': 56000,              // price
	'cloid': 'my-client-id',  // optional client order id
	'reduce_only': false,
	'order_type': {'limit': {'tif': 'Gtc'}},
};

final resp = await trader.exchange.placeOrder(order);
print(resp);
```

### Batch Order Placement

```dart
await trader.exchange.placeOrder({
	'grouping': 'na',
	'orders': [
		{'coin': 'ETH', 'is_buy': true, 'sz': 0.05, 'px': 2500, 'reduce_only': false, 'order_type': {'limit': {'tif': 'Gtc'}}},
		{'coin': 'ETH', 'is_buy': false, 'sz': 0.05, 'px': 2700, 'reduce_only': false, 'order_type': {'limit': {'tif': 'Gtc'}}},
	],
});
```

### Cancels & Modifies

```dart
// Cancel by raw oid + coin
await trader.exchange.cancelOrder({'coin': 'BTC', 'o': 123456});

// Modify an existing order
await trader.exchange.modifyOrder(123456, {
	'coin': 'BTC',
	'is_buy': true,
	'sz': 0.002,
	'px': 55500,
	'reduce_only': false,
	'order_type': {'limit': {'tif': 'Gtc'}},
});
```

### TWAP Order

```dart
await trader.exchange.placeTwapOrder({
	'coin': 'BTC',
	'is_buy': true,
	'sz': 0.01,
	'reduce_only': false,
	'minutes': 30,
	'randomize': true,
});
```

## Info API Examples

```dart
final fills = await client.info.getUserFills('0xWalletAddress');
final l2 = await client.info.getL2Book('ETH');
final candles = await client.info.getCandleSnapshot('ETH', '1m', startMs, endMs);
```

All info methods accept `rawResponse: true` to bypass model decoding if you prefer raw maps.

## Symbol Conversion & Asset Indexes

Many trading calls require an internal asset index. The SDK resolves & caches this for you. You can also query:

```dart
final idx = await client.info.getAssetIndex('BTC');
final internal = await client.info.getInternalName('BTC');
final all = await client.info.getAllAssets(); // { 'perpetuals': [...], 'spot': [...] }
```

Periodic refresh is enabled by default. You can control it:

```dart
client.disableAssetMapRefresh();
client.enableAssetMapRefresh();
client.setAssetMapRefreshInterval(120000); // 2 minutes
```

## Nonce Strategy

Each signed action uses a strictly increasing millisecond nonce (ties resolved by +1). This ensures order in-flight uniqueness even under rapid submissions.

## WebSocket (Preview)

Basic connection management is implemented; subscription helpers will expand in future releases.

```dart
final wsClient = Hyperliquid(const HyperliquidConfig(testnet: true, enableWs: true));
await wsClient.connect();
print('WS connected: ${wsClient.isWebSocketConnected()}');
```

## Error Handling

Currently most methods throw on network / validation errors. Wrap calls in `try/catch` for production use. Additional typed error classes are planned.

## Testing

Run package tests:

```sh
dart test
```

Key covered utilities: nonce sequencing, signing, rate limiting, symbol conversion.

## Roadmap

- [ ] Full WebSocket subscription & streaming models (order book, trades, fills)
- [ ] Expanded typed models for all info endpoints
- [ ] Enhanced error taxonomy
- [ ] Automatic backoff / retry strategies
- [ ] More examples (Flutter integration, streaming strategies)

## Contributing

Contributions welcome! Please open an issue to discuss significant changes. Typical flow:

1. Fork & branch
2. Add/adjust code + tests
3. Run `dart format . && dart test`
4. Open PR with context

## Security Notice

Never commit private keys. When using environment variables or secrets managers, load them at runtime and avoid logging sensitive material.

## License

MIT – see [LICENSE](LICENSE).

## Disclaimer

This SDK is community maintained and not an official Hyperliquid product. Use at your own risk. Trading digital assets involves risk of loss.

---

Questions or ideas? Open an issue – feedback accelerates stabilization.


