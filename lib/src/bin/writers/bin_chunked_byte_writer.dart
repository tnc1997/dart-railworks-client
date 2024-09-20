import '../../common/writers/chunked_byte_writer.dart';
import 'bin_byte_writer_base.dart';

class BinChunkedByteWriter extends ChunkedByteWriter with BinByteWriterBase {
  BinChunkedByteWriter(
    Sink<List<int>> sink,
  ) : super(sink);
}
