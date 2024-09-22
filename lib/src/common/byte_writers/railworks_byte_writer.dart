import 'dart:typed_data';

abstract class RailWorksByteWriter {
  void writeBool(
    bool value,
  ) {
    writeByte(value ? 1 : 0);
  }

  void writeByte(
    int byte,
  );

  void writeBytes(
    List<int> bytes,
  );

  void writeFloat32(
    double value, [
    Endian endian = Endian.big,
  ]) {
    writeBytes(Uint8List(4)..buffer.asByteData().setFloat32(0, value, endian));
  }

  void writeFloat64(
    double value, [
    Endian endian = Endian.big,
  ]) {
    writeBytes(Uint8List(8)..buffer.asByteData().setFloat64(0, value, endian));
  }

  void writeInt8(
    int value,
  ) {
    writeBytes(Uint8List(1)..buffer.asByteData().setInt8(0, value));
  }

  void writeInt16(
    int value, [
    Endian endian = Endian.big,
  ]) {
    writeBytes(Uint8List(2)..buffer.asByteData().setInt16(0, value, endian));
  }

  void writeInt32(
    int value, [
    Endian endian = Endian.big,
  ]) {
    writeBytes(Uint8List(4)..buffer.asByteData().setInt32(0, value, endian));
  }

  void writeInt64(
    int value, [
    Endian endian = Endian.big,
  ]) {
    writeBytes(Uint8List(8)..buffer.asByteData().setInt64(0, value, endian));
  }

  void writeUint8(
    int value,
  ) {
    writeBytes(Uint8List(1)..buffer.asByteData().setUint8(0, value));
  }

  void writeUint16(
    int value, [
    Endian endian = Endian.big,
  ]) {
    writeBytes(Uint8List(2)..buffer.asByteData().setUint16(0, value, endian));
  }

  void writeUint32(
    int value, [
    Endian endian = Endian.big,
  ]) {
    writeBytes(Uint8List(4)..buffer.asByteData().setUint32(0, value, endian));
  }

  void writeUint64(
    int value, [
    Endian endian = Endian.big,
  ]) {
    writeBytes(Uint8List(8)..buffer.asByteData().setUint64(0, value, endian));
  }
}
