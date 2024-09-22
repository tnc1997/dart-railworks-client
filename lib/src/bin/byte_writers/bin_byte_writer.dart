import '../../common/byte_writers/railworks_byte_writer.dart';
import '../models/bin_element.dart';

abstract class BinByteWriter extends RailWorksByteWriter {
  void writeElement(
    BinElement element,
  );
}
