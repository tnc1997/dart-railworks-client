import '../../common/byte_writers/railworks_chunked_byte_writer.dart';
import 'bin_byte_writer_base.dart';

class BinChunkedByteWriter extends RailWorksChunkedByteWriter
    with BinByteWriterBase {
  BinChunkedByteWriter(
    Sink<List<int>> sink,
  ) : super(sink);
}
