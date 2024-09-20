import 'byte_writer_base.dart';

class ChunkedByteWriter with ByteWriterBase {
  final Sink<List<int>> _sink;

  ChunkedByteWriter(
    this._sink,
  );

  @override
  void writeByte(
    int byte,
  ) {
    writeBytes([byte]);
  }

  @override
  void writeBytes(
    List<int> bytes,
  ) {
    _sink.add(bytes);
  }
}
