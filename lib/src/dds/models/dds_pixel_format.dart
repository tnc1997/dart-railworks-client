import '../constants/dds_d3d_formats.dart';
import '../constants/dds_dxgi_formats.dart';
import '../constants/dds_pixel_format_flags.dart';
import 'dds.dart';
import 'dds_header_dxt10.dart';

class DdsPixelFormat {
  /// Size of structure.
  final size = 0x20;

  /// Values which indicate what type of data is in the surface.
  final int flags;

  /// Four-character codes for specifying compressed or custom formats. A [fourCc] of [DdsD3dFormats.dx10] indicates the presence of the [Dds.header10] extended header, and the [DdsHeaderDxt10.dxgiFormat] member of that structure indicates the true format. When using a four-character code, [flags] must include [DdsPixelFormatFlags.fourCc].
  final int? fourCc;

  /// Number of bits in an RGB (possibly including alpha) format. Valid when [flags] includes [DdsPixelFormatFlags.rgb], [DdsPixelFormatFlags.luminance], or [DdsPixelFormatFlags.yuv].
  final int? rgbBitCount;

  /// Red (or luminance or Y) mask for reading color data. For instance, given the [DdsDxgiFormats.b8g8r8a8Unorm] format, the red mask would be 0x00ff0000.
  final int? rBitMask;

  /// Green (or U) mask for reading color data. For instance, given the [DdsDxgiFormats.b8g8r8a8Unorm] format, the green mask would be 0x0000ff00.
  final int? gBitMask;

  /// Blue (or V) mask for reading color data. For instance, given the [DdsDxgiFormats.b8g8r8a8Unorm] format, the blue mask would be 0x000000ff.
  final int? bBitMask;

  /// Alpha mask for reading alpha data. [flags] must include [DdsPixelFormatFlags.alphaPixels] or [DdsPixelFormatFlags.alpha]. For instance, given the [DdsDxgiFormats.b8g8r8a8Unorm] format, the alpha mask would be 0xff000000.
  final int? aBitMask;

  DdsPixelFormat({
    int? flags,
    this.fourCc,
    this.rgbBitCount,
    this.rBitMask,
    this.gBitMask,
    this.bBitMask,
    this.aBitMask,
  }) : flags = flags ??
            (aBitMask != null ? DdsPixelFormatFlags.alphaPixels : 0x0) |
                (fourCc != null ? DdsPixelFormatFlags.fourCc : 0x0) |
                (rgbBitCount != null &&
                        rBitMask != null &&
                        gBitMask != null &&
                        bBitMask != null
                    ? DdsPixelFormatFlags.rgb
                    : 0x0);
}
