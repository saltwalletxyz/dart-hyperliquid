import 'dart:convert';
import 'dart:typed_data';

import 'package:msgpack_dart/msgpack_dart.dart';
import 'package:web3dart/web3dart.dart';

import 'hash.dart' as hashKeccak;

class Wallet {
  Wallet(String privateKey) : credentials = EthPrivateKey.fromHex(privateKey);
  final EthPrivateKey credentials;

  String get address => credentials.address.toString();

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
  return hashKeccak.keccak256(data);
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
  // Proper EIP-712 signing implementation
  final domain = payload['domain'] as Map<String, dynamic>;
  final types = payload['types'] as Map<String, dynamic>;
  final primaryType = payload['primaryType'] as String;
  final message = payload['message'] as Map<String, dynamic>;

  // Compute domain separator
  final domainSeparator = hashKeccak.keccak256(_encodeDomain(domain));

  // Compute struct hash
  final structHash = hashKeccak.keccak256(_encodeTypeData(primaryType, message, types));

  // Compute EIP-712 typed data hash
  final typedDataHash = hashKeccak.keccak256(Uint8List.fromList([0x19, 0x01, ...domainSeparator, ...structHash]));

  // Sign the typed data hash as personal message
  final signature = key.signPersonalMessageToUint8List(typedDataHash);

  return {
    'r': '0x${bytesToHex(signature.sublist(0, 32))}',
    's': '0x${bytesToHex(signature.sublist(32, 64))}',
    'v': signature[64],
  };
}

/// Encodes the EIP-712 domain according to ABI rules
Uint8List _encodeDomain(Map<String, dynamic> domain) {
  final parts = <Uint8List>[];
  parts.add(
      hashKeccak.keccak256(utf8.encode('EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)')));
  parts.add(hashKeccak.keccak256(utf8.encode(domain['name'] as String? ?? '')));
  parts.add(hashKeccak.keccak256(utf8.encode(domain['version'] as String? ?? '')));
  parts.add(Uint8List(32)..buffer.asByteData().setUint64(0, (domain['chainId'] as num? ?? 0).toInt(), Endian.big));
  if (domain.containsKey('verifyingContract')) {
    parts.add(hexToBytes((domain['verifyingContract'] as String).toLowerCase()));
  }
  return _abiEncodePacked(parts);
}

/// Encodes the typed data struct according to ABI rules
Uint8List _encodeTypeData(String primaryType, Map<String, dynamic> message, Map<String, dynamic> types) {
  final typeDef = types[primaryType] as List<dynamic>;
  final encodedFields = <Uint8List>[];
  final fieldOrder = <String>[];

  // Get field order from type definition
  for (final field in typeDef) {
    final fieldMap = field as Map<String, dynamic>;
    fieldOrder.add(fieldMap['name'] as String);
  }

  // Encode each field
  for (final fieldName in fieldOrder) {
    final fieldValue = message[fieldName];
    final fieldType = _getFieldType(primaryType, fieldName, types);
    encodedFields.add(_encodeField(fieldType, fieldValue));
  }

  return _abiEncodePacked(encodedFields);
}

/// Gets the type for a specific field
String _getFieldType(String structType, String fieldName, Map<String, dynamic> types) {
  final typeDef = types[structType] as List<dynamic>;
  for (final field in typeDef) {
    final fieldMap = field as Map<String, dynamic>;
    if (fieldMap['name'] == fieldName) {
      return fieldMap['type'] as String;
    }
  }
  throw Exception('Field $fieldName not found in type $structType');
}

/// Encodes a single field value based on its type
Uint8List _encodeField(String type, dynamic value) {
  switch (type) {
    case 'string':
      return hashKeccak.keccak256(utf8.encode(value as String? ?? ''));
    case 'bytes32':
      return hexToBytes(value as String);
    case 'address':
      return hexToBytes((value as String).toLowerCase());
    case 'uint256':
    case 'uint64':
      final numValue = BigInt.parse(value.toString());
      final padded = Uint8List(32);
      final bytes = numValue.toRadixString(16).padLeft(64, '0');
      for (int i = 0; i < 32; i++) {
        padded[i] = int.parse(bytes.substring(i * 2, i * 2 + 2), radix: 16);
      }
      return padded;
    case 'bool':
      return Uint8List(32)..[31] = (value as bool) ? 1 : 0;
    default:
      throw Exception('Unsupported type: $type');
  }
}

/// ABI encodes packed (concatenates without length prefixes for fixed-size types)
Uint8List _abiEncodePacked(List<Uint8List> parts) {
  final totalLength = parts.fold<int>(0, (sum, part) => sum + part.length);
  final result = Uint8List(totalLength);
  var offset = 0;
  for (final part in parts) {
    result.setAll(offset, part);
    offset += part.length;
  }
  return result;
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
