import 'byte_writer_base.dart';

class UnchunkedByteWriter with ByteWriterBase {
  final Sink<int> _sink;

  UnchunkedByteWriter(
    this._sink,
  );

  @override
  void writeByte(
    int byte,
  ) {
    _sink.add(byte);
  }

  @override
  void writeBytes(
    List<int> bytes,
  ) {
    for (final byte in bytes) {
      writeByte(byte);
    }
  }
}
