import '../../common/byte_readers/railworks_stream_byte_reader.dart';
import '../models/bin_element.dart';

abstract class BinStreamByteReader extends RailWorksStreamByteReader {
  Future<BinElement> readElement();
}
