import '../../common/byte_readers/railworks_unchunked_stream_byte_reader.dart';
import 'bin_stream_byte_reader_base.dart';

class BinUnchunkedStreamByteReader extends RailWorksUnchunkedStreamByteReader
    with BinStreamByteReaderBase {
  BinUnchunkedStreamByteReader(
    Stream<int> bytes,
  ) : super(bytes);
}
