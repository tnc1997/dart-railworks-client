import '../../common/readers/byte_reader.dart';
import '../models/bin_element.dart';

abstract class BinByteReader extends ByteReader {
  BinElement readElement();
}
