import '../../common/readers/railworks_byte_reader.dart';
import '../models/bin_element.dart';

abstract class BinByteReader extends RailWorksByteReader {
  BinElement readElement();
}
