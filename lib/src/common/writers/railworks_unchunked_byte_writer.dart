import 'railworks_byte_writer_base.dart';

class RailWorksUnchunkedByteWriter with RailWorksByteWriterBase {
  final Sink<int> _sink;

  RailWorksUnchunkedByteWriter(
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
