import '../../common/readers/unchunked_byte_reader.dart';
import 'bin_byte_reader_base.dart';

class BinUnchunkedByteReader extends UnchunkedByteReader
    with BinByteReaderBase {
  BinUnchunkedByteReader(
    Iterable<int> bytes,
  ) : super(bytes);
}
