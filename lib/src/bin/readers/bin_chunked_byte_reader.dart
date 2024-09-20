import '../../common/readers/chunked_byte_reader.dart';
import 'bin_byte_reader_base.dart';

class BinChunkedByteReader extends ChunkedByteReader with BinByteReaderBase {
  BinChunkedByteReader(
    Iterable<List<int>> bytes,
  ) : super(bytes);
}
