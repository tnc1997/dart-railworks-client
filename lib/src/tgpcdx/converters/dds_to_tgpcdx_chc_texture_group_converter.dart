import 'dart:convert';
import 'dart:math';

import '../../dds/constants/dds_caps.dart';
import '../../dds/constants/dds_d3d_formats.dart';
import '../../dds/constants/dds_dxgi_formats.dart';
import '../../dds/constants/dds_header_flags.dart';
import '../../dds/constants/dds_pixel_format_flags.dart';
import '../../dds/models/dds.dart';
import '../constants/tgpcdx_texture_formats.dart';
import '../models/tgpcdx_chc_image_dx.dart';
import '../models/tgpcdx_chc_texture.dart';
import '../models/tgpcdx_chc_texture_data.dart';
import '../models/tgpcdx_chc_texture_group.dart';
import '../models/tgpcdx_data.dart';
import '../models/tgpcdx_mip.dart';
import '../models/tgpcdx_palette.dart';
import '../models/tgpcdx_texture.dart';

class DdsToTgpcdxChcTextureGroupConverter
    extends Converter<Dds, TgpcdxChcTextureGroup> {
  final String chcTextureName;

  const DdsToTgpcdxChcTextureGroupConverter({
    required this.chcTextureName,
  });

  @override
  TgpcdxChcTextureGroup convert(
    Dds input,
  ) {
    final random = Random();

    return TgpcdxChcTextureGroup(
      id: random.nextInt(4294967295) + 1,
      texture: TgpcdxTexture(
        chcTexture: TgpcdxChcTexture(
          id: random.nextInt(4294967295) + 1,
          width: input.header.width,
          height: input.header.height,
          name: chcTextureName,
          data: TgpcdxData(
            chcTextureData: TgpcdxChcTextureData(
              id: random.nextInt(4294967295) + 1,
              mip: TgpcdxMip(
                chcImageDxs: _getChcImageDxs(input, random).toList(),
              ),
              palette: const TgpcdxPalette(),
            ),
          ),
        ),
      ),
    );
  }

  Iterable<TgpcdxChcImageDx> _getChcImageDxs(
    Dds dds,
    Random random,
  ) sync* {
    final format = _getTextureFormat(
      dds.header.pixelFormat.flags,
      dxgiFormat: dds.header10?.dxgiFormat,
      fourCc: dds.header.pixelFormat.fourCc,
    );

    if (dds.header.caps & DdsCaps.mipMap != 0x0) {
      if (dds.header.flags & DdsHeaderFlags.mipMapCount == 0x0) {
        throw Exception('Invalid header flags');
      }

      final mipMapCount = dds.header.mipMapCount;
      if (mipMapCount == null) {
        throw Exception('Invalid mip map count');
      }

      var offset = 0;
      var width = dds.header.width;
      var height = dds.header.height;

      for (var i = 0; i < mipMapCount; i++) {
        final size = _getLayerSize(
          format,
          width,
          height,
          rgbBitCount: dds.header.pixelFormat.rgbBitCount,
        );

        yield TgpcdxChcImageDx(
          id: random.nextInt(4294967295) + 1,
          format: format,
          isSwizzled: false,
          width: width,
          height: height,
          blob: dds.data.sublist(offset, offset + size),
        );

        if (width == 1 && height == 1) {
          break;
        }

        offset += size;
        width = max<int>(1, width ~/ 2);
        height = max<int>(1, height ~/ 2);
      }
    } else {
      yield TgpcdxChcImageDx(
        id: random.nextInt(4294967295) + 1,
        format: format,
        isSwizzled: false,
        width: dds.header.width,
        height: dds.header.height,
        blob: dds.data,
      );
    }
  }

  int _getCompressionBlockSize(
    String format,
  ) {
    // https://learn.microsoft.com/en-us/windows/win32/direct3ddds/dds-file-layout-for-textures
    switch (format) {
      case TgpcdxTextureFormats.compressed:
        return 8;
      case TgpcdxTextureFormats.compressedExplicitAlpha:
      case TgpcdxTextureFormats.compressedInterpolatedAlpha:
        return 16;
      default:
        throw Exception('Invalid texture format');
    }
  }

  int _getLayerSize(
    String format,
    int width,
    int height, {
    int? rgbBitCount,
  }) {
    // https://learn.microsoft.com/en-us/windows/win32/direct3ddds/dds-file-layout-for-textures
    switch (format) {
      case TgpcdxTextureFormats.col888:
      case TgpcdxTextureFormats.cola8888:
        if (rgbBitCount == null) {
          throw Exception('Invalid rgb bit count');
        }

        final pitch = (width * rgbBitCount + 7) ~/ 8;

        return pitch * height;
      case TgpcdxTextureFormats.compressed:
      case TgpcdxTextureFormats.compressedExplicitAlpha:
      case TgpcdxTextureFormats.compressedInterpolatedAlpha:
        return max<int>(1, (width + 3) ~/ 4) *
            max<int>(1, (height + 3) ~/ 4) *
            _getCompressionBlockSize(format);
      default:
        throw Exception('Invalid texture format');
    }
  }

  String _getTextureFormat(
    int pixelFormatFlags, {
    int? dxgiFormat,
    int? fourCc,
  }) {
    if (pixelFormatFlags & DdsPixelFormatFlags.fourCc != 0x0) {
      switch (fourCc) {
        case DdsD3dFormats.dxt1:
          return TgpcdxTextureFormats.compressed;
        case DdsD3dFormats.dxt2:
          return TgpcdxTextureFormats.compressedExplicitAlpha;
        case DdsD3dFormats.dxt3:
          return TgpcdxTextureFormats.compressedInterpolatedAlpha;
        case DdsD3dFormats.dx10:
          switch (dxgiFormat) {
            case DdsDxgiFormats.bc1Unorm:
              return TgpcdxTextureFormats.compressed;
            case DdsDxgiFormats.bc2Unorm:
              return TgpcdxTextureFormats.compressedExplicitAlpha;
            case DdsDxgiFormats.bc3Unorm:
              return TgpcdxTextureFormats.compressedInterpolatedAlpha;
            default:
              throw Exception('Invalid dxgi format');
          }
        default:
          throw Exception('Invalid four cc');
      }
    }

    if (pixelFormatFlags & DdsPixelFormatFlags.alphaPixels != 0x0) {
      return TgpcdxTextureFormats.cola8888;
    }

    return TgpcdxTextureFormats.col888;
  }
}
