import '../constants/dds_dxgi_formats.dart';
import 'dds_header.dart';
import 'dds_header_dxt10.dart';

class Dds {
  /// A magic number containing the four character code value 'DDS '.
  final magic = 0x20534444;

  /// A description of the data in the file.
  final DdsHeader header;

  /// An additional structure to accommodate texture arrays or [DdsDxgiFormats] that cannot be expressed as an RGB pixel format.
  final DdsHeaderDxt10? header10;

  /// A pointer to an array of bytes that contains the surface data.
  final List<int> data;

  const Dds({
    required this.header,
    this.header10,
    required this.data,
  });
}
