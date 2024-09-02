import '../constants/dds_caps.dart';
import '../constants/dds_header_flags.dart';
import 'dds_pixel_format.dart';

class DdsHeader {
  /// Size of structure.
  final size = 0x7c;

  /// Flags to indicate which members contain valid data.
  final int flags;

  /// Surface height (in pixels).
  final int height;

  /// Surface width (in pixels).
  final int width;

  /// The pitch or number of bytes per scan line in an uncompressed texture; the total number of bytes in the top level texture for a compressed texture. For information about how to compute the pitch, see the DDS File Layout section of the [Programming Guide for DDS](https://learn.microsoft.com/en-us/windows/win32/direct3ddds/dx-graphics-dds-pguide).
  final int pitchOrLinearSize;

  /// Depth of a volume texture (in pixels).
  final int? depth;

  /// Number of mipmap levels.
  final int? mipMapCount;

  /// The pixel format.
  final DdsPixelFormat pixelFormat;

  /// Specifies the complexity of the surfaces stored.
  final int caps;

  /// Additional detail about the surfaces stored.
  final int caps2;

  final int caps3;

  final int caps4;

  const DdsHeader({
    int? flags,
    required this.height,
    required this.width,
    required this.pitchOrLinearSize,
    this.depth,
    this.mipMapCount,
    required this.pixelFormat,
    int? caps,
    this.caps2 = 0x0,
    this.caps3 = 0x0,
    this.caps4 = 0x0,
  })  : flags = flags ??
            DdsHeaderFlags.caps |
                DdsHeaderFlags.height |
                DdsHeaderFlags.width |
                DdsHeaderFlags.pixelFormat |
                (mipMapCount != null && mipMapCount > 1
                    ? DdsHeaderFlags.mipMapCount
                    : 0x0) |
                (depth != null && depth > 1 ? DdsHeaderFlags.depth : 0x0),
        caps = caps ??
            DdsCaps.texture |
                ((depth != null && depth > 1) ||
                        (mipMapCount != null && mipMapCount > 1)
                    ? DdsCaps.complex
                    : 0x0) |
                (mipMapCount != null && mipMapCount > 1 ? DdsCaps.mipMap : 0x0);
}
