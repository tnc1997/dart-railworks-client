import '../../common/byte_writers/railworks_unchunked_byte_writer.dart';
import 'bin_byte_writer_base.dart';

class BinUnchunkedByteWriter extends RailWorksUnchunkedByteWriter
    with BinByteWriterBase {
  BinUnchunkedByteWriter(
    Sink<int> sink,
  ) : super(sink);
}
