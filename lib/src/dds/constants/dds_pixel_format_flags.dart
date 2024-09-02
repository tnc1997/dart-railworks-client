import '../models/dds_pixel_format.dart';

class DdsPixelFormatFlags {
  /// Texture contains alpha data; [DdsPixelFormat.aBitMask] contains valid data.
  static const alphaPixels = 0x1;

  /// Used in some older .dds files for alpha channel only uncompressed data ([DdsPixelFormat.rgbBitCount] contains the alpha channel bit count; [DdsPixelFormat.aBitMask] contains valid data).
  static const alpha = 0x2;

  /// Texture contains compressed RGB data; [DdsPixelFormat.fourCc] contains valid data.
  static const fourCc = 0x4;

  /// Texture contains uncompressed RGB data; [DdsPixelFormat.rgbBitCount] and the RGB masks ([DdsPixelFormat.rBitMask], [DdsPixelFormat.gBitMask], [DdsPixelFormat.bBitMask]) contain valid data.
  static const rgb = 0x40;

  /// Used in some older .dds files for YUV uncompressed data ([DdsPixelFormat.rgbBitCount] contains the YUV bit count; [DdsPixelFormat.rBitMask] contains the Y mask, [DdsPixelFormat.gBitMask] contains the U mask, [DdsPixelFormat.bBitMask] contains the V mask).
  static const yuv = 0x200;

  /// Used in some older .dds files for single channel color uncompressed data ([DdsPixelFormat.rgbBitCount] contains the luminance channel bit count; [DdsPixelFormat.rBitMask] contains the channel mask). Can be combined with [alphaPixels] for a two channel .dds file.
  static const luminance = 0x20000;
}
