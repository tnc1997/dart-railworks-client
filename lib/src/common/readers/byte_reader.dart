import 'dart:typed_data';

class ByteReader {
  final Iterator<int> _iterator;

  ByteReader(
    List<int> bytes,
  ) : _iterator = bytes.iterator..moveNext();

  bool readBool() {
    return readByte() == 1;
  }

  int readByte() {
    try {
      return _iterator.current;
    } finally {
      _iterator.moveNext();
    }
  }

  Uint8List readBytes(
    int length,
  ) {
    final bytes = Uint8List(length);

    for (var i = 0; i < length; i++) {
      try {
        bytes[i] = readByte();
      } catch (e) {
        return bytes.sublist(0, length - (i + 1));
      }
    }

    return bytes;
  }

  double readFloat32([
    Endian endian = Endian.big,
  ]) {
    return readBytes(4).buffer.asByteData().getFloat32(0, endian);
  }

  double readFloat64([
    Endian endian = Endian.big,
  ]) {
    return readBytes(8).buffer.asByteData().getFloat64(0, endian);
  }

  int readInt8() {
    return readBytes(1).buffer.asByteData().getInt8(0);
  }

  int readInt16([
    Endian endian = Endian.big,
  ]) {
    return readBytes(2).buffer.asByteData().getInt16(0, endian);
  }

  int readInt32([
    Endian endian = Endian.big,
  ]) {
    return readBytes(4).buffer.asByteData().getInt32(0, endian);
  }

  int readInt64([
    Endian endian = Endian.big,
  ]) {
    return readBytes(8).buffer.asByteData().getInt64(0, endian);
  }

  int readUint8() {
    return readBytes(1).buffer.asByteData().getUint8(0);
  }

  int readUint16([
    Endian endian = Endian.big,
  ]) {
    return readBytes(2).buffer.asByteData().getUint16(0, endian);
  }

  int readUint32([
    Endian endian = Endian.big,
  ]) {
    return readBytes(4).buffer.asByteData().getUint32(0, endian);
  }

  int readUint64([
    Endian endian = Endian.big,
  ]) {
    return readBytes(8).buffer.asByteData().getUint64(0, endian);
  }
}
