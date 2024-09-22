import '../../common/readers/unchunked_stream_byte_reader.dart';
import 'bin_stream_byte_reader_base.dart';

class BinUnchunkedStreamByteReader extends UnchunkedStreamByteReader
    with BinStreamByteReaderBase {
  BinUnchunkedStreamByteReader(
    Stream<int> bytes,
  ) : super(bytes);
}
