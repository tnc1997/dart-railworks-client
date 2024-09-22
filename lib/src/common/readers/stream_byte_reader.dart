import 'dart:typed_data';

abstract class StreamByteReader {
  Future<bool> readBool();

  Future<int> readByte();

  Future<Uint8List> readBytes(
    int length,
  );

  Future<double> readFloat32([
    Endian endian = Endian.big,
  ]);

  Future<double> readFloat64([
    Endian endian = Endian.big,
  ]);

  Future<int> readInt8();

  Future<int> readInt16([
    Endian endian = Endian.big,
  ]);

  Future<int> readInt32([
    Endian endian = Endian.big,
  ]);

  Future<int> readInt64([
    Endian endian = Endian.big,
  ]);

  Future<int> readUint8();

  Future<int> readUint16([
    Endian endian = Endian.big,
  ]);

  Future<int> readUint32([
    Endian endian = Endian.big,
  ]);

  Future<int> readUint64([
    Endian endian = Endian.big,
  ]);
}
