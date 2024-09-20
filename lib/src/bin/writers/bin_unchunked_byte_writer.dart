import '../../common/writers/unchunked_byte_writer.dart';
import 'bin_byte_writer_base.dart';

class BinUnchunkedByteWriter extends UnchunkedByteWriter
    with BinByteWriterBase {
  BinUnchunkedByteWriter(
    Sink<int> sink,
  ) : super(sink);
}
