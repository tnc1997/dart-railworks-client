import '../../common/readers/railworks_chunked_byte_reader.dart';
import 'bin_byte_reader_base.dart';

class BinChunkedByteReader extends RailWorksChunkedByteReader
    with BinByteReaderBase {
  BinChunkedByteReader(
    Iterable<List<int>> bytes,
  ) : super(bytes);
}
