import '../../dds/constants/dds_d3d_formats.dart';
import '../../dds/constants/dds_dxgi_formats.dart';

class TgpcdxTextureFormats {
  /// [DdsDxgiFormats.b8g8r8x8Unorm]
  /// [DdsD3dFormats.x8r8g8b8]
  static const col888 = 'HC_IMAGE_FORMAT_COL888';

  /// [DdsDxgiFormats.b8g8r8a8Unorm]
  /// [DdsD3dFormats.a8r8g8b8]
  static const cola8888 = 'HC_IMAGE_FORMAT_COLA8888';

  /// [DdsDxgiFormats.bc1Unorm]
  /// [DdsD3dFormats.dxt1]
  static const compressed = 'HC_IMAGE_FORMAT_COMPRESSED';

  /// [DdsDxgiFormats.bc2Unorm]
  /// [DdsD3dFormats.dxt3]
  static const compressedExplicitAlpha =
      'HC_IMAGE_FORMAT_COMPRESSED_EXPL_ALPHA';

  /// [DdsDxgiFormats.bc3Unorm]
  /// [DdsD3dFormats.dxt5]
  static const compressedInterpolatedAlpha =
      'HC_IMAGE_FORMAT_COMPRESSED_INTERP_ALPHA';
}
