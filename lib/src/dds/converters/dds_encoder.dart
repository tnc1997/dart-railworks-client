import 'dart:convert';
import 'dart:typed_data';

import '../../common/writers/byte_writer.dart';
import '../../common/writers/chunked_byte_writer.dart';
import '../constants/dds_d3d_formats.dart';
import '../exceptions/dds_header10_required_exception.dart';
import '../models/dds.dart';

/// A converter that encodes a [Dds] to bytes.
class DdsEncoder extends Converter<Dds, List<int>> {
  const DdsEncoder();

  @override
  List<int> convert(
    Dds input,
  ) {
    final header = input.header;
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
      final header10 = input.header10;
      if (header10 == null) {
        throw DdsHeader10RequiredException(
          'The header10 is required when the four cc is DX10',
        );
      }

      data.setUint32(0x80, header10.dxgiFormat, Endian.little);
      data.setUint32(0x84, header10.resourceDimension, Endian.little);
      data.setUint32(0x88, header10.miscFlag, Endian.little);
      data.setUint32(0x8c, header10.arraySize, Endian.little);
      data.setUint32(0x90, header10.miscFlags2, Endian.little);
    }

    return bytes..setAll(bytes.length - input.data.length, input.data);
  }

  @override
  Sink<Dds> startChunkedConversion(
    Sink<List<int>> sink,
  ) {
    return _DdsEncoderSink(sink);
  }
}

class _DdsEncoderSink implements Sink<Dds> {
  final Sink<List<int>> _sink;
  final ByteWriter _writer;

  _DdsEncoderSink(this._sink) : _writer = ChunkedByteWriter(_sink);

  @override
  void add(
    Dds data,
  ) {
    final header = data.header;
    final pixelFormat = header.pixelFormat;

    _writer.writeUint32(data.magic, Endian.little);

    _writer.writeUint32(header.size, Endian.little);
    _writer.writeUint32(header.flags, Endian.little);
    _writer.writeUint32(header.height, Endian.little);
    _writer.writeUint32(header.width, Endian.little);
    _writer.writeUint32(header.pitchOrLinearSize, Endian.little);
    _writer.writeUint32(header.depth ?? 0x0, Endian.little);
    _writer.writeUint32(header.mipMapCount ?? 0x0, Endian.little);

    _writer.writeBytes(List.filled(4 * 11, 0x0));

    _writer.writeUint32(pixelFormat.size, Endian.little);
    _writer.writeUint32(pixelFormat.flags, Endian.little);
    _writer.writeUint32(pixelFormat.fourCc ?? 0x0, Endian.little);
    _writer.writeUint32(pixelFormat.rgbBitCount ?? 0x0, Endian.little);
    _writer.writeUint32(pixelFormat.rBitMask ?? 0x0, Endian.little);
    _writer.writeUint32(pixelFormat.gBitMask ?? 0x0, Endian.little);
    _writer.writeUint32(pixelFormat.bBitMask ?? 0x0, Endian.little);
    _writer.writeUint32(pixelFormat.aBitMask ?? 0x0, Endian.little);

    _writer.writeUint32(header.caps, Endian.little);
    _writer.writeUint32(header.caps2, Endian.little);
    _writer.writeUint32(header.caps3, Endian.little);
    _writer.writeUint32(header.caps4, Endian.little);

    _writer.writeBytes(List.filled(4 * 1, 0x0));

    if (pixelFormat.fourCc == DdsD3dFormats.dx10) {
      final header10 = data.header10;
      if (header10 == null) {
        throw DdsHeader10RequiredException(
          'The header10 is required when the four cc is DX10',
        );
      }

      _writer.writeUint32(header10.dxgiFormat, Endian.little);
      _writer.writeUint32(header10.resourceDimension, Endian.little);
      _writer.writeUint32(header10.miscFlag, Endian.little);
      _writer.writeUint32(header10.arraySize, Endian.little);
      _writer.writeUint32(header10.miscFlags2, Endian.little);
    }

    _writer.writeBytes(data.data);
  }

  @override
  void close() {
    _sink.close();
  }
}
