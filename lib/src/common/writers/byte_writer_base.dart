import 'dart:typed_data';

import 'byte_writer.dart';

mixin ByteWriterBase implements ByteWriter {
  @override
  void writeBool(
    bool value,
  ) {
    writeByte(value ? 1 : 0);
  }

  @override
  void writeFloat32(
    double value, [
    Endian endian = Endian.big,
  ]) {
    writeBytes(Uint8List(4)..buffer.asByteData().setFloat32(0, value, endian));
  }

  @override
  void writeFloat64(
    double value, [
    Endian endian = Endian.big,
  ]) {
    writeBytes(Uint8List(8)..buffer.asByteData().setFloat64(0, value, endian));
  }

  @override
  void writeInt8(
    int value,
  ) {
    writeBytes(Uint8List(1)..buffer.asByteData().setInt8(0, value));
  }

  @override
  void writeInt16(
    int value, [
    Endian endian = Endian.big,
  ]) {
    writeBytes(Uint8List(2)..buffer.asByteData().setInt16(0, value, endian));
  }

  @override
  void writeInt32(
    int value, [
    Endian endian = Endian.big,
  ]) {
    writeBytes(Uint8List(4)..buffer.asByteData().setInt32(0, value, endian));
  }

  @override
  void writeInt64(
    int value, [
    Endian endian = Endian.big,
  ]) {
    writeBytes(Uint8List(8)..buffer.asByteData().setInt64(0, value, endian));
  }

  @override
  void writeUint8(
    int value,
  ) {
    writeBytes(Uint8List(1)..buffer.asByteData().setUint8(0, value));
  }

  @override
  void writeUint16(
    int value, [
    Endian endian = Endian.big,
  ]) {
    writeBytes(Uint8List(2)..buffer.asByteData().setUint16(0, value, endian));
  }

  @override
  void writeUint32(
    int value, [
    Endian endian = Endian.big,
  ]) {
    writeBytes(Uint8List(4)..buffer.asByteData().setUint32(0, value, endian));
  }

  @override
  void writeUint64(
    int value, [
    Endian endian = Endian.big,
  ]) {
    writeBytes(Uint8List(8)..buffer.asByteData().setUint64(0, value, endian));
  }
}
