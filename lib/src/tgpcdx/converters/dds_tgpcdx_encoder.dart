import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';

import '../../dds/constants/dds_caps.dart';
import '../../dds/constants/dds_d3d_formats.dart';
import '../../dds/constants/dds_header_flags.dart';
import '../../dds/constants/dds_pixel_format_flags.dart';
import '../../dds/models/dds.dart';
import '../../dds/models/dds_header.dart';
import '../../dds/models/dds_pixel_format.dart';
import '../constants/tgpcdx_texture_formats.dart';
import '../exceptions/tgpcdx_texture_format_invalid_exception.dart';
import '../models/tgpcdx_chc_image_dx.dart';
import '../models/tgpcdx_chc_texture_group.dart';

/// A converter that encodes a [TgpcdxChcTextureGroup] to a [Dds].
class DdsTgpcdxEncoder extends Converter<TgpcdxChcTextureGroup, Dds> {
  const DdsTgpcdxEncoder();

  @override
  Dds convert(
    TgpcdxChcTextureGroup input,
  ) {
    return Dds(
      header: _getHeader(input),
      data:
          _getData(input.texture.chcTexture.data.chcTextureData.mip.chcImageDxs)
              .toList(),
    );
  }

  @override
  Sink<TgpcdxChcTextureGroup> startChunkedConversion(
    Sink<Dds> sink,
  ) {
    return _DdsTgpcdxEncoderSink(sink);
  }
}

class _DdsTgpcdxEncoderSink implements Sink<TgpcdxChcTextureGroup> {
  final Sink<Dds> _sink;

  _DdsTgpcdxEncoderSink(this._sink);

  @override
  void add(
    TgpcdxChcTextureGroup data,
  ) {
    _sink.add(
      Dds(
        header: _getHeader(data),
        data: _getData(
                data.texture.chcTexture.data.chcTextureData.mip.chcImageDxs)
            .toList(),
      ),
    );
  }

  @override
  void close() {
    _sink.close();
  }
}

int? _getABitMask(
  String format,
) {
  switch (format) {
    case TgpcdxTextureFormats.col888:
    case TgpcdxTextureFormats.compressed:
    case TgpcdxTextureFormats.compressedExplicitAlpha:
    case TgpcdxTextureFormats.compressedInterpolatedAlpha:
      return null;
    case TgpcdxTextureFormats.cola8888:
      return 0xff000000;
    default:
      throw TgpcdxTextureFormatInvalidException(null, format);
  }
}

int? _getBBitMask(
  String format,
) {
  switch (format) {
    case TgpcdxTextureFormats.col888:
    case TgpcdxTextureFormats.cola8888:
      return 0xff;
    case TgpcdxTextureFormats.compressed:
    case TgpcdxTextureFormats.compressedExplicitAlpha:
    case TgpcdxTextureFormats.compressedInterpolatedAlpha:
      return null;
    default:
      throw TgpcdxTextureFormatInvalidException(null, format);
  }
}

int _getCaps(
  List<TgpcdxChcImageDx> chcImageDxs,
) {
  var caps = DdsCaps.texture;

  if (chcImageDxs.length > 1) {
    caps |= DdsCaps.complex | DdsCaps.mipMap;
  }

  return caps;
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
      throw TgpcdxTextureFormatInvalidException(null, format);
  }
}

Iterable<int> _getData(
  List<TgpcdxChcImageDx> chcImageDxs,
) sync* {
  for (final chcImageDx in chcImageDxs.sorted(
    (a, b) {
      if (a.width >= a.height) {
        return a.width - b.width;
      } else {
        return a.height - b.height;
      }
    },
  ).reversed) {
    yield* chcImageDx.blob;
  }
}

int? _getFourCc(
  String format,
) {
  switch (format) {
    case TgpcdxTextureFormats.col888:
    case TgpcdxTextureFormats.cola8888:
      return null;
    case TgpcdxTextureFormats.compressed:
      return DdsD3dFormats.dxt1;
    case TgpcdxTextureFormats.compressedExplicitAlpha:
      return DdsD3dFormats.dxt3;
    case TgpcdxTextureFormats.compressedInterpolatedAlpha:
      return DdsD3dFormats.dxt5;
    default:
      throw TgpcdxTextureFormatInvalidException(null, format);
  }
}

int? _getGBitMask(
  String format,
) {
  switch (format) {
    case TgpcdxTextureFormats.col888:
    case TgpcdxTextureFormats.cola8888:
      return 0xff00;
    case TgpcdxTextureFormats.compressed:
    case TgpcdxTextureFormats.compressedExplicitAlpha:
    case TgpcdxTextureFormats.compressedInterpolatedAlpha:
      return null;
    default:
      throw TgpcdxTextureFormatInvalidException(null, format);
  }
}

DdsHeader _getHeader(
  TgpcdxChcTextureGroup chcTextureGroup,
) {
  return DdsHeader(
    flags: _getHeaderFlags(
        chcTextureGroup.texture.chcTexture.data.chcTextureData.mip.chcImageDxs
            .first.format,
        chcTextureGroup.texture.chcTexture.data.chcTextureData.mip.chcImageDxs),
    height: chcTextureGroup.texture.chcTexture.height,
    width: chcTextureGroup.texture.chcTexture.width,
    pitchOrLinearSize: _getPitchOrLinearSize(
        chcTextureGroup.texture.chcTexture.data.chcTextureData.mip.chcImageDxs
            .first.format,
        chcTextureGroup.texture.chcTexture.width),
    depth: null,
    mipMapCount: chcTextureGroup
                .texture.chcTexture.data.chcTextureData.mip.chcImageDxs.length >
            1
        ? chcTextureGroup
            .texture.chcTexture.data.chcTextureData.mip.chcImageDxs.length
        : null,
    pixelFormat: _getPixelFormat(chcTextureGroup),
    caps: _getCaps(
        chcTextureGroup.texture.chcTexture.data.chcTextureData.mip.chcImageDxs),
  );
}

int _getHeaderFlags(
  String format,
  List<TgpcdxChcImageDx> chcImageDxs,
) {
  var flags = DdsHeaderFlags.caps |
      DdsHeaderFlags.height |
      DdsHeaderFlags.width |
      DdsHeaderFlags.pixelFormat;

  switch (format) {
    case TgpcdxTextureFormats.col888:
    case TgpcdxTextureFormats.cola8888:
      flags |= DdsHeaderFlags.pitch;
      break;
    case TgpcdxTextureFormats.compressed:
    case TgpcdxTextureFormats.compressedExplicitAlpha:
    case TgpcdxTextureFormats.compressedInterpolatedAlpha:
      flags |= DdsHeaderFlags.linearSize;
      break;
    default:
      throw TgpcdxTextureFormatInvalidException(null, format);
  }

  if (chcImageDxs.length > 1) {
    flags |= DdsHeaderFlags.mipMapCount;
  }

  return flags;
}

int _getPitchOrLinearSize(
  String format,
  int width,
) {
  // https://learn.microsoft.com/en-us/windows/win32/direct3ddds/dx-graphics-dds-pguide
  switch (format) {
    case TgpcdxTextureFormats.col888:
    case TgpcdxTextureFormats.cola8888:
      return (width * 32 + 7) ~/ 8;
    case TgpcdxTextureFormats.compressed:
    case TgpcdxTextureFormats.compressedExplicitAlpha:
    case TgpcdxTextureFormats.compressedInterpolatedAlpha:
      return max(1, ((width + 3) ~/ 4)) * _getCompressionBlockSize(format);
    default:
      throw TgpcdxTextureFormatInvalidException(null, format);
  }
}

DdsPixelFormat _getPixelFormat(
  TgpcdxChcTextureGroup chcTextureGroup,
) {
  return DdsPixelFormat(
    flags: _getPixelFormatFlags(chcTextureGroup
        .texture.chcTexture.data.chcTextureData.mip.chcImageDxs.first.format),
    fourCc: _getFourCc(chcTextureGroup
        .texture.chcTexture.data.chcTextureData.mip.chcImageDxs.first.format),
    rgbBitCount: _getRgbBitCount(chcTextureGroup
        .texture.chcTexture.data.chcTextureData.mip.chcImageDxs.first.format),
    rBitMask: _getRBitMask(chcTextureGroup
        .texture.chcTexture.data.chcTextureData.mip.chcImageDxs.first.format),
    gBitMask: _getGBitMask(chcTextureGroup
        .texture.chcTexture.data.chcTextureData.mip.chcImageDxs.first.format),
    bBitMask: _getBBitMask(chcTextureGroup
        .texture.chcTexture.data.chcTextureData.mip.chcImageDxs.first.format),
    aBitMask: _getABitMask(chcTextureGroup
        .texture.chcTexture.data.chcTextureData.mip.chcImageDxs.first.format),
  );
}

int _getPixelFormatFlags(
  String format,
) {
  switch (format) {
    case TgpcdxTextureFormats.col888:
      return DdsPixelFormatFlags.rgb;
    case TgpcdxTextureFormats.cola8888:
      return DdsPixelFormatFlags.alphaPixels | DdsPixelFormatFlags.rgb;
    case TgpcdxTextureFormats.compressed:
    case TgpcdxTextureFormats.compressedExplicitAlpha:
    case TgpcdxTextureFormats.compressedInterpolatedAlpha:
      return DdsPixelFormatFlags.fourCc;
    default:
      throw TgpcdxTextureFormatInvalidException(null, format);
  }
}

int? _getRBitMask(
  String format,
) {
  switch (format) {
    case TgpcdxTextureFormats.col888:
    case TgpcdxTextureFormats.cola8888:
      return 0xff0000;
    case TgpcdxTextureFormats.compressed:
    case TgpcdxTextureFormats.compressedExplicitAlpha:
    case TgpcdxTextureFormats.compressedInterpolatedAlpha:
      return null;
    default:
      throw TgpcdxTextureFormatInvalidException(null, format);
  }
}

int? _getRgbBitCount(
  String format,
) {
  switch (format) {
    case TgpcdxTextureFormats.col888:
    case TgpcdxTextureFormats.cola8888:
      return 32;
    case TgpcdxTextureFormats.compressed:
    case TgpcdxTextureFormats.compressedExplicitAlpha:
    case TgpcdxTextureFormats.compressedInterpolatedAlpha:
      return null;
    default:
      throw TgpcdxTextureFormatInvalidException(null, format);
  }
}
