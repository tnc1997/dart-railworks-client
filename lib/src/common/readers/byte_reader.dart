import 'dart:typed_data';

abstract class ByteReader {
  bool readBool();

  int readByte();

  Uint8List readBytes(
    int length,
  );

  double readFloat32([
    Endian endian = Endian.big,
  ]);

  double readFloat64([
    Endian endian = Endian.big,
  ]);

  int readInt8();

  int readInt16([
    Endian endian = Endian.big,
  ]);

  int readInt32([
    Endian endian = Endian.big,
  ]);

  int readInt64([
    Endian endian = Endian.big,
  ]);

  int readUint8();

  int readUint16([
    Endian endian = Endian.big,
  ]);

  int readUint32([
    Endian endian = Endian.big,
  ]);

  int readUint64([
    Endian endian = Endian.big,
  ]);
}
