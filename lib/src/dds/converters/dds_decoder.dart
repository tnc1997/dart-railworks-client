import 'dart:convert';
import 'dart:typed_data';

import '../constants/dds_d3d_formats.dart';
import '../constants/dds_header_flags.dart';
import '../constants/dds_pixel_format_flags.dart';
import '../models/dds.dart';
import '../models/dds_header.dart';
import '../models/dds_header_dxt10.dart';
import '../models/dds_pixel_format.dart';

/// A converter that decodes bytes to a [Dds].
class DdsDecoder extends Converter<List<int>, Dds> {
  const DdsDecoder();

  @override
  Dds convert(
    List<int> input,
  ) {
    final bytes = input is Uint8List ? input : Uint8List.fromList(input);

    final data = bytes.buffer.asByteData();

    final pixelFormatFlags = data.getUint32(0x50, Endian.little);
    final pixelFormat = DdsPixelFormat(
      flags: pixelFormatFlags,
      fourCc: pixelFormatFlags & DdsPixelFormatFlags.fourCc != 0x0
          ? data.getUint32(0x54, Endian.little)
          : null,
      rgbBitCount: pixelFormatFlags & DdsPixelFormatFlags.alpha != 0x0 ||
              pixelFormatFlags & DdsPixelFormatFlags.rgb != 0x0 ||
              pixelFormatFlags & DdsPixelFormatFlags.yuv != 0x0 ||
              pixelFormatFlags & DdsPixelFormatFlags.luminance != 0x0
          ? data.getUint32(0x58, Endian.little)
          : null,
      rBitMask: pixelFormatFlags & DdsPixelFormatFlags.rgb != 0x0 ||
              pixelFormatFlags & DdsPixelFormatFlags.yuv != 0x0 ||
              pixelFormatFlags & DdsPixelFormatFlags.luminance != 0x0
          ? data.getUint32(0x5c, Endian.little)
          : null,
      gBitMask: pixelFormatFlags & DdsPixelFormatFlags.rgb != 0x0 ||
              pixelFormatFlags & DdsPixelFormatFlags.yuv != 0x0
          ? data.getUint32(0x60, Endian.little)
          : null,
      bBitMask: pixelFormatFlags & DdsPixelFormatFlags.rgb != 0x0 ||
              pixelFormatFlags & DdsPixelFormatFlags.yuv != 0x0
          ? data.getUint32(0x64, Endian.little)
          : null,
      aBitMask: pixelFormatFlags & DdsPixelFormatFlags.alphaPixels != 0x0 ||
              pixelFormatFlags & DdsPixelFormatFlags.alpha != 0x0
          ? data.getUint32(0x68, Endian.little)
          : null,
    );

    final headerFlags = data.getUint32(0x8, Endian.little);
    final header = DdsHeader(
      flags: headerFlags,
      height: data.getUint32(0xc, Endian.little),
      width: data.getUint32(0x10, Endian.little),
      pitchOrLinearSize: data.getUint32(0x14, Endian.little),
      depth: headerFlags & DdsHeaderFlags.depth != 0x0
          ? data.getUint32(0x18, Endian.little)
          : null,
      mipMapCount: headerFlags & DdsHeaderFlags.mipMapCount != 0x0
          ? data.getUint32(0x1c, Endian.little)
          : null,
      pixelFormat: pixelFormat,
      caps: data.getUint32(0x6c, Endian.little),
      caps2: data.getUint32(0x70, Endian.little),
      caps3: data.getUint32(0x74, Endian.little),
      caps4: data.getUint32(0x78, Endian.little),
    );

    DdsHeaderDxt10? header10 = null;
    if (pixelFormat.fourCc == DdsD3dFormats.dx10) {
      header10 = DdsHeaderDxt10(
        dxgiFormat: data.getUint32(0x80, Endian.little),
        resourceDimension: data.getUint32(0x84, Endian.little),
        miscFlag: data.getUint32(0x88, Endian.little),
        arraySize: data.getUint32(0x8c, Endian.little),
        miscFlags2: data.getUint32(0x90, Endian.little),
      );
    }

    return Dds(
      header: header,
      header10: header10,
      data: input.sublist(
        pixelFormat.fourCc == DdsD3dFormats.dx10 ? 0x94 : 0x80,
      ),
    );
  }

  @override
  Sink<List<int>> startChunkedConversion(
    Sink<Dds> sink,
  ) {
    return ByteConversionSink.withCallback(
      (accumulated) {
        sink.add(convert(accumulated));
      },
    );
  }
}
