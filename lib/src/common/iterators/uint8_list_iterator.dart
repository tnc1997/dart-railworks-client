import 'dart:typed_data';

class Uint8ListIterator implements Iterator<int> {
  final Uint8List _list;
  int _position;

  Uint8ListIterator(
    Uint8List list,
  )   : _list = list,
        _position = -1;

  @override
  int get current {
    return _list[_position];
  }

  @override
  bool moveNext() {
    return ++_position < _list.length;
  }

  bool readBool() {
    return readByte() == 1;
  }

  int readByte() {
    try {
      return current;
    } finally {
      moveNext();
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
