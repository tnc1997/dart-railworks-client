import 'railworks_byte_writer_base.dart';

class RailWorksChunkedByteWriter with RailWorksByteWriterBase {
  final Sink<List<int>> _sink;

  RailWorksChunkedByteWriter(
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
