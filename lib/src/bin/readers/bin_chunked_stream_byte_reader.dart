import '../../common/readers/railworks_chunked_stream_byte_reader.dart';
import 'bin_stream_byte_reader_base.dart';

class BinChunkedStreamByteReader extends RailWorksChunkedStreamByteReader
    with BinStreamByteReaderBase {
  BinChunkedStreamByteReader(
    Stream<List<int>> bytes,
  ) : super(bytes);
}
