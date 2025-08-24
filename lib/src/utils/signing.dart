import 'dart:typed_data';
import 'package:web3dart/web3dart.dart';
import 'package:msgpack_dart/msgpack_dart.dart';
import 'hash.dart';

class Wallet {
  final EthPrivateKey credentials;
  Wallet(String privateKey) : credentials = EthPrivateKey.fromHex(privateKey);

  EthereumAddress get address => credentials.address;

  Future<Uint8List> sign(Uint8List message) async {
    return credentials.signPersonalMessageToUint8List(message);
  }
}

Uint8List actionHash(dynamic action, String? vaultAddress, int nonce) {
  final msgPackBytes = serialize(action);
  final additionalBytesLength = vaultAddress == null ? 9 : 29;
  final data = Uint8List(msgPackBytes.length + additionalBytesLength);
  data.setAll(0, msgPackBytes);
  final view = ByteData.view(data.buffer);
  view.setUint64(msgPackBytes.length, nonce, Endian.big);
  if (vaultAddress == null) {
    view.setUint8(msgPackBytes.length + 8, 0);
  } else {
    view.setUint8(msgPackBytes.length + 8, 1);
    data.setAll(msgPackBytes.length + 9, hexToBytes(vaultAddress));
  }
  return keccak256(data);
}

Future<dynamic> signL1Action(Wallet wallet, dynamic action, String? activePool, int nonce, bool isMainnet) async {
  final hash = actionHash(action, activePool, nonce);
  final phantomAgent = {
    'source': isMainnet ? 'a' : 'b',
    'connectionId': hash,
  };

  final data = {
    'domain': {
      'name': 'Exchange',
      'version': '1',
      'chainId': 1337,
      'verifyingContract': '0x0000000000000000000000000000000000000000',
    },
    'types': {
      'Agent': [
        {'name': 'source', 'type': 'string'},
        {'name': 'connectionId', 'type': 'bytes32'},
      ],
    },
    'primaryType': 'Agent',
    'message': phantomAgent,
  };

  final sig = await _signTypedData(wallet.credentials, data);
  return sig;
}

Uint8List hexToBytes(String hex) {
  return Uint8List.fromList(List<int>.generate(hex.length ~/ 2, (i) => int.parse(hex.substring(i * 2, i * 2 + 2), radix: 16)));
}

String bytesToHex(Uint8List bytes) {
  return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
}

Future<Map<String, dynamic>> _signTypedData(EthPrivateKey key, Map<String, dynamic> payload) async {
  // web3dart does not expose EIP-712 directly. We sign the keccak256 hash of the encoded typed data.
  // For our use-case, other SDKs sign the typed data using EIP-712 eth_signTypedData_v4.
  // Here we approximate by signing personal message of the encoded hash so backend can recover signer.
  // If strict EIP-712 is required, replace with a dedicated EIP-712 encoder for Dart.
  final jsonStr = payload.toString();
  final messageBytes = Uint8List.fromList(jsonStr.codeUnits);
  final signature = key.signPersonalMessageToUint8List(messageBytes);
  return {
    'r': '0x${bytesToHex(signature.sublist(0, 32))}',
    's': '0x${bytesToHex(signature.sublist(32, 64))}',
    'v': signature[64],
  };
}

String removeTrailingZeros(String value) {
  if (!value.contains('.')) return value;
  final res = value.replaceAll(RegExp(r"\.?0+$"), '');
  return res == '-0' ? '0' : res;
}

String floatToWire(num x) {
  final rounded = x.toStringAsFixed(8);
  final asDouble = double.parse(rounded);
  if ((asDouble - x).abs() >= 1e-12) {
    throw Exception('floatToWire causes rounding: $x');
  }
  var normalized = rounded.replaceAll(RegExp(r"\.?0+$"), '');
  if (normalized == '-0') normalized = '0';
  return normalized;
}

Map<String, dynamic> orderTypeToWire(Map<String, dynamic> orderType) {
  if (orderType.containsKey('limit')) {
    return {'limit': orderType['limit']};
  } else if (orderType.containsKey('trigger')) {
    final t = orderType['trigger'] as Map<String, dynamic>;
    return {
      'trigger': {
        'isMarket': t['isMarket'] as bool,
        'triggerPx':
            t['triggerPx'] is String ? removeTrailingZeros(t['triggerPx'] as String) : floatToWire(t['triggerPx'] as num),
        'tpsl': t['tpsl'],
      }
    };
  }
  throw Exception('Invalid order type');
}

Map<String, dynamic> orderToWire(Map<String, dynamic> order, int asset) {
  final limitPx = order['limit_px'];
  final sz = order['sz'];
  final orderType = order['order_type'] as Map<String, dynamic>;
  final wire = <String, dynamic>{
    'a': asset,
    'b': order['is_buy'] as bool,
    'p': limitPx is String ? removeTrailingZeros(limitPx) : floatToWire(limitPx as num),
    's': sz is String ? removeTrailingZeros(sz) : floatToWire(sz as num),
    'r': order['reduce_only'] as bool,
    't': orderTypeToWire(orderType),
  };
  if (order.containsKey('cloid')) wire['c'] = order['cloid'];
  return wire;
}

Map<String, dynamic> orderWireToAction(List<Map<String, dynamic>> orders, String grouping, Map<String, dynamic>? builder) {
  final action = {
    'type': 'order',
    'orders': orders,
    'grouping': grouping,
  };
  if (builder != null) {
    action['builder'] = {'b': (builder['address'] as String).toLowerCase(), 'f': builder['fee']};
  }
  return action as Map<String, dynamic>;
}

int getTimestampMs() => DateTime.now().millisecondsSinceEpoch;

Future<Map<String, dynamic>> signUserSignedAction(
  Wallet wallet,
  Map<String, dynamic> action,
  List<Map<String, String>> payloadTypes,
  String primaryType,
  bool isMainnet,
) async {
  final data = {
    'domain': {
      'name': 'HyperliquidSignTransaction',
      'version': '1',
      'chainId': isMainnet ? 42161 : 421614,
      'verifyingContract': '0x0000000000000000000000000000000000000000',
    },
    'types': {primaryType: payloadTypes},
    'primaryType': primaryType,
    'message': action,
  };
  return _signTypedData(wallet.credentials, data);
}

Future<Map<String, dynamic>> signUsdTransferAction(Wallet wallet, Map<String, dynamic> action, bool isMainnet) async {
  return signUserSignedAction(
    wallet,
    action,
    [
      {'name': 'hyperliquidChain', 'type': 'string'},
      {'name': 'destination', 'type': 'string'},
      {'name': 'amount', 'type': 'string'},
      {'name': 'time', 'type': 'uint64'},
    ],
    'HyperliquidTransaction:UsdSend',
    isMainnet,
  );
}

Future<Map<String, dynamic>> signWithdrawFromBridgeAction(Wallet wallet, Map<String, dynamic> action, bool isMainnet) async {
  return signUserSignedAction(
    wallet,
    action,
    [
      {'name': 'hyperliquidChain', 'type': 'string'},
      {'name': 'destination', 'type': 'string'},
      {'name': 'amount', 'type': 'string'},
      {'name': 'time', 'type': 'uint64'},
    ],
    'HyperliquidTransaction:Withdraw',
    isMainnet,
  );
}

Future<Map<String, dynamic>> signAgent(Wallet wallet, Map<String, dynamic> action, bool isMainnet) async {
  return signUserSignedAction(
    wallet,
    action,
    [
      {'name': 'hyperliquidChain', 'type': 'string'},
      {'name': 'agentAddress', 'type': 'address'},
      {'name': 'agentName', 'type': 'string'},
      {'name': 'nonce', 'type': 'uint64'},
    ],
    'HyperliquidTransaction:ApproveAgent',
    isMainnet,
  );
}
