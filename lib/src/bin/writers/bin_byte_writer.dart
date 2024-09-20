import '../../common/writers/byte_writer.dart';
import '../models/bin_element.dart';

abstract class BinByteWriter extends ByteWriter {
  void writeElement(
    BinElement element,
  );
}
