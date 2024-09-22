import 'dart:typed_data';

import '../exceptions/railworks_end_of_iterable_exception.dart';
import 'railworks_byte_reader.dart';

mixin RailWorksByteReaderBase implements RailWorksByteReader {
  @override
  bool readBool() {
    return readByte() == 1;
  }

  @override
  double readFloat32([
    Endian endian = Endian.big,
  ]) {
    final bytes = readBytes(4);
    if (bytes.length < 4) {
      throw RailWorksEndOfIterableException();
    }

    return bytes.buffer.asByteData().getFloat32(0, endian);
  }

  @override
  double readFloat64([
    Endian endian = Endian.big,
  ]) {
    final bytes = readBytes(8);
    if (bytes.length < 8) {
      throw RailWorksEndOfIterableException();
    }

    return bytes.buffer.asByteData().getFloat64(0, endian);
  }

  @override
  int readInt8() {
    final bytes = readBytes(1);
    if (bytes.length < 1) {
      throw RailWorksEndOfIterableException();
    }

    return bytes.buffer.asByteData().getInt8(0);
  }

  @override
  int readInt16([
    Endian endian = Endian.big,
  ]) {
    final bytes = readBytes(2);
    if (bytes.length < 2) {
      throw RailWorksEndOfIterableException();
    }

    return bytes.buffer.asByteData().getInt16(0, endian);
  }

  @override
  int readInt32([
    Endian endian = Endian.big,
  ]) {
    final bytes = readBytes(4);
    if (bytes.length < 4) {
      throw RailWorksEndOfIterableException();
    }

    return bytes.buffer.asByteData().getInt32(0, endian);
  }

  @override
  int readInt64([
    Endian endian = Endian.big,
  ]) {
    final bytes = readBytes(8);
    if (bytes.length < 8) {
      throw RailWorksEndOfIterableException();
    }

    return bytes.buffer.asByteData().getInt64(0, endian);
  }

  @override
  int readUint8() {
    final bytes = readBytes(1);
    if (bytes.length < 1) {
      throw RailWorksEndOfIterableException();
    }

    return bytes.buffer.asByteData().getUint8(0);
  }

  @override
  int readUint16([
    Endian endian = Endian.big,
  ]) {
    final bytes = readBytes(2);
    if (bytes.length < 2) {
      throw RailWorksEndOfIterableException();
    }

    return bytes.buffer.asByteData().getUint16(0, endian);
  }

  @override
  int readUint32([
    Endian endian = Endian.big,
  ]) {
    final bytes = readBytes(4);
    if (bytes.length < 4) {
      throw RailWorksEndOfIterableException();
    }

    return bytes.buffer.asByteData().getUint32(0, endian);
  }

  @override
  int readUint64([
    Endian endian = Endian.big,
  ]) {
    final bytes = readBytes(8);
    if (bytes.length < 8) {
      throw RailWorksEndOfIterableException();
    }

    return bytes.buffer.asByteData().getUint64(0, endian);
  }
}
