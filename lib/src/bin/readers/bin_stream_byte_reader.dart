import '../../common/readers/stream_byte_reader.dart';
import '../models/bin_element.dart';

abstract class BinStreamByteReader extends StreamByteReader {
  Future<BinElement> readElement();
}
