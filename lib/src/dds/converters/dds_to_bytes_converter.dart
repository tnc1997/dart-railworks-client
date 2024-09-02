import 'dart:convert';
import 'dart:typed_data';

import '../constants/dds_d3d_formats.dart';
import '../models/dds.dart';

/// A converter that converts a [Dds] to bytes.
class DdsToBytesConverter extends Converter<Dds, List<int>> {
  const DdsToBytesConverter();

  @override
  List<int> convert(
    Dds input,
  ) {
    final header = input.header;
    final header10 = input.header10;
    final pixelFormat = header.pixelFormat;

    final bytes = Uint8List(
      (pixelFormat.fourCc == DdsD3dFormats.dx10 ? 0x94 : 0x80) +
          input.data.length,
    );

    final data = bytes.buffer.asByteData();

    data.setUint32(0x0, input.magic, Endian.little);

    data.setUint32(0x4, header.size, Endian.little);
    data.setUint32(0x8, header.flags, Endian.little);
    data.setUint32(0xc, header.height, Endian.little);
    data.setUint32(0x10, header.width, Endian.little);
    data.setUint32(0x14, header.pitchOrLinearSize, Endian.little);
    data.setUint32(0x18, header.depth ?? 0x0, Endian.little);
    data.setUint32(0x1c, header.mipMapCount ?? 0x0, Endian.little);

    data.setUint32(0x4c, pixelFormat.size, Endian.little);
    data.setUint32(0x50, pixelFormat.flags, Endian.little);
    data.setUint32(0x54, pixelFormat.fourCc ?? 0x0, Endian.little);
    data.setUint32(0x58, pixelFormat.rgbBitCount ?? 0x0, Endian.little);
    data.setUint32(0x5c, pixelFormat.rBitMask ?? 0x0, Endian.little);
    data.setUint32(0x60, pixelFormat.gBitMask ?? 0x0, Endian.little);
    data.setUint32(0x64, pixelFormat.bBitMask ?? 0x0, Endian.little);
    data.setUint32(0x68, pixelFormat.aBitMask ?? 0x0, Endian.little);

    data.setUint32(0x6c, header.caps, Endian.little);
    data.setUint32(0x70, header.caps2, Endian.little);
    data.setUint32(0x74, header.caps3, Endian.little);
    data.setUint32(0x78, header.caps4, Endian.little);

    if (pixelFormat.fourCc == DdsD3dFormats.dx10) {
      if (header10 == null) {
        throw Exception('header10 must not be null if four cc is DX10');
      }
      data.setUint32(0x80, header10.dxgiFormat, Endian.little);
      data.setUint32(0x84, header10.resourceDimension, Endian.little);
      data.setUint32(0x88, header10.miscFlag, Endian.little);
      data.setUint32(0x8c, header10.arraySize, Endian.little);
      data.setUint32(0x90, header10.miscFlags2, Endian.little);
    }

    return bytes..setAll(bytes.length - input.data.length, input.data);
  }
}
