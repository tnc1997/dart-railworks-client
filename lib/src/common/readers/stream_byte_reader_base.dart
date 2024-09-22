import 'dart:async';
import 'dart:typed_data';

import '../exceptions/railworks_end_of_stream_exception.dart';
import 'stream_byte_reader.dart';

mixin StreamByteReaderBase implements StreamByteReader {
  @override
  Future<bool> readBool() async {
    return await readByte() == 1;
  }

  @override
  Future<double> readFloat32([
    Endian endian = Endian.big,
  ]) async {
    final bytes = await readBytes(4);
    if (bytes.length < 4) {
      throw RailWorksEndOfStreamException();
    }

    return bytes.buffer.asByteData().getFloat32(0, endian);
  }

  @override
  Future<double> readFloat64([
    Endian endian = Endian.big,
  ]) async {
    final bytes = await readBytes(8);
    if (bytes.length < 8) {
      throw RailWorksEndOfStreamException();
    }

    return bytes.buffer.asByteData().getFloat64(0, endian);
  }

  @override
  Future<int> readInt8() async {
    final bytes = await readBytes(1);
    if (bytes.length < 1) {
      throw RailWorksEndOfStreamException();
    }

    return bytes.buffer.asByteData().getInt8(0);
  }

  @override
  Future<int> readInt16([
    Endian endian = Endian.big,
  ]) async {
    final bytes = await readBytes(2);
    if (bytes.length < 2) {
      throw RailWorksEndOfStreamException();
    }

    return bytes.buffer.asByteData().getInt16(0, endian);
  }

  @override
  Future<int> readInt32([
    Endian endian = Endian.big,
  ]) async {
    final bytes = await readBytes(4);
    if (bytes.length < 4) {
      throw RailWorksEndOfStreamException();
    }

    return bytes.buffer.asByteData().getInt32(0, endian);
  }

  @override
  Future<int> readInt64([
    Endian endian = Endian.big,
  ]) async {
    final bytes = await readBytes(8);
    if (bytes.length < 8) {
      throw RailWorksEndOfStreamException();
    }

    return bytes.buffer.asByteData().getInt64(0, endian);
  }

  @override
  Future<int> readUint8() async {
    final bytes = await readBytes(1);
    if (bytes.length < 1) {
      throw RailWorksEndOfStreamException();
    }

    return bytes.buffer.asByteData().getUint8(0);
  }

  @override
  Future<int> readUint16([
    Endian endian = Endian.big,
  ]) async {
    final bytes = await readBytes(2);
    if (bytes.length < 2) {
      throw RailWorksEndOfStreamException();
    }

    return bytes.buffer.asByteData().getUint16(0, endian);
  }

  @override
  Future<int> readUint32([
    Endian endian = Endian.big,
  ]) async {
    final bytes = await readBytes(4);
    if (bytes.length < 4) {
      throw RailWorksEndOfStreamException();
    }

    return bytes.buffer.asByteData().getUint32(0, endian);
  }

  @override
  Future<int> readUint64([
    Endian endian = Endian.big,
  ]) async {
    final bytes = await readBytes(8);
    if (bytes.length < 8) {
      throw RailWorksEndOfStreamException();
    }

    return bytes.buffer.asByteData().getUint64(0, endian);
  }
}
