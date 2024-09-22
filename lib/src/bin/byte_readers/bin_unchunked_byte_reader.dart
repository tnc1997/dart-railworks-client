import '../../common/byte_readers/railworks_unchunked_byte_reader.dart';
import 'bin_byte_reader_base.dart';

class BinUnchunkedByteReader extends RailWorksUnchunkedByteReader
    with BinByteReaderBase {
  BinUnchunkedByteReader(
    Iterable<int> bytes,
  ) : super(bytes);
}
