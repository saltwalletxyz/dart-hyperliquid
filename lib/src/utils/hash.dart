import 'dart:typed_data';
import 'package:pointycastle/digests/keccak.dart';

Uint8List keccak256(Uint8List input) {
  final digest = KeccakDigest(256);
  return digest.process(input);
}
