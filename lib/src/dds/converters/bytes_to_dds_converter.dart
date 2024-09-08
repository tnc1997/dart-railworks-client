import 'dart:convert';
import 'dart:typed_data';

import '../constants/dds_d3d_formats.dart';
import '../constants/dds_header_flags.dart';
import '../constants/dds_pixel_format_flags.dart';
import '../models/dds.dart';
import '../models/dds_header.dart';
import '../models/dds_header_dxt10.dart';
import '../models/dds_pixel_format.dart';

/// A converter that converts bytes to a [Dds].
class BytesToDdsConverter extends Converter<List<int>, Dds> {
  const BytesToDdsConverter();

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
    return _BytesToDdsConverterSink(
      sink: sink,
    );
  }
}

class _BytesToDdsConverterSink extends ByteConversionSink {
  final Sink<Dds> _sink;

  final _bytes = Uint8List(4);
  final _data = <int>[];
  var _index = 0;

  int? _pixelFormatFlags;
  int? _fourCc;
  int? _rgbBitCount;
  int? _rBitMask;
  int? _gBitMask;
  int? _bBitMask;
  int? _aBitMask;

  int? _headerFlags;
  int? _height;
  int? _width;
  int? _pitchOrLinearSize;
  int? _depth;
  int? _mipMapCount;
  int? _caps;
  int? _caps2;
  int? _caps3;
  int? _caps4;

  int? _dxgiFormat;
  int? _resourceDimension;
  int? _miscFlag;
  int? _arraySize;
  int? _miscFlags2;

  _BytesToDdsConverterSink({
    required Sink<Dds> sink,
  }) : _sink = sink;

  @override
  void add(
    List<int> chunk,
  ) {
    for (final byte in chunk) {
      if (_index >= (_fourCc == DdsD3dFormats.dx10 ? 0x94 : 0x80)) {
        _data.add(byte);
      } else {
        _bytes[_index % 4] = byte;

        switch (_index) {
          case 0xb:
            _headerFlags = _getUint32();
            break;
          case 0xf:
            _height = _getUint32();
            break;
          case 0x13:
            _width = _getUint32();
            break;
          case 0x17:
            _pitchOrLinearSize = _getUint32();
            break;
          case 0x1b:
            _depth = _getUint32();
            break;
          case 0x1f:
            _mipMapCount = _getUint32();
            break;
          case 0x53:
            _pixelFormatFlags = _getUint32();
            break;
          case 0x57:
            _fourCc = _getUint32();
            break;
          case 0x5b:
            _rgbBitCount = _getUint32();
            break;
          case 0x5f:
            _rBitMask = _getUint32();
            break;
          case 0x63:
            _gBitMask = _getUint32();
            break;
          case 0x67:
            _bBitMask = _getUint32();
            break;
          case 0x6b:
            _aBitMask = _getUint32();
            break;
          case 0x6f:
            _caps = _getUint32();
            break;
          case 0x73:
            _caps2 = _getUint32();
            break;
          case 0x77:
            _caps3 = _getUint32();
            break;
          case 0x7b:
            _caps4 = _getUint32();
            break;
          case 0x7f:
            _caps4 = _getUint32();
            break;
          case 0x83 when _fourCc == DdsD3dFormats.dx10:
            _dxgiFormat = _getUint32();
            break;
          case 0x87 when _fourCc == DdsD3dFormats.dx10:
            _resourceDimension = _getUint32();
            break;
          case 0x8b when _fourCc == DdsD3dFormats.dx10:
            _miscFlag = _getUint32();
            break;
          case 0x8f when _fourCc == DdsD3dFormats.dx10:
            _arraySize = _getUint32();
            break;
          case 0x93 when _fourCc == DdsD3dFormats.dx10:
            _miscFlags2 = _getUint32();
            break;
        }
      }

      _index += 1;
    }
  }

  @override
  void close() {
    final pixelFormatFlags = _pixelFormatFlags;
    final fourCc = _fourCc;
    final rgbBitCount = _rgbBitCount;
    final rBitMask = _rBitMask;
    final gBitMask = _gBitMask;
    final bBitMask = _bBitMask;
    final aBitMask = _aBitMask;

    final headerFlags = _headerFlags;
    final height = _height;
    final width = _width;
    final pitchOrLinearSize = _pitchOrLinearSize;
    final depth = _depth;
    final mipMapCount = _mipMapCount;
    final caps = _caps;
    final caps2 = _caps2;
    final caps3 = _caps3;
    final caps4 = _caps4;

    final dxgiFormat = _dxgiFormat;
    final resourceDimension = _resourceDimension;
    final miscFlag = _miscFlag;
    final arraySize = _arraySize;
    final miscFlags2 = _miscFlags2;

    if (pixelFormatFlags != null &&
        headerFlags != null &&
        height != null &&
        width != null &&
        pitchOrLinearSize != null &&
        caps != null &&
        caps2 != null &&
        caps3 != null &&
        caps4 != null) {
      final pixelFormat = DdsPixelFormat(
        flags: pixelFormatFlags,
        fourCc: pixelFormatFlags & DdsPixelFormatFlags.fourCc != 0x0
            ? fourCc
            : null,
        rgbBitCount: pixelFormatFlags & DdsPixelFormatFlags.alpha != 0x0 ||
                pixelFormatFlags & DdsPixelFormatFlags.rgb != 0x0 ||
                pixelFormatFlags & DdsPixelFormatFlags.yuv != 0x0 ||
                pixelFormatFlags & DdsPixelFormatFlags.luminance != 0x0
            ? rgbBitCount
            : null,
        rBitMask: pixelFormatFlags & DdsPixelFormatFlags.rgb != 0x0 ||
                pixelFormatFlags & DdsPixelFormatFlags.yuv != 0x0 ||
                pixelFormatFlags & DdsPixelFormatFlags.luminance != 0x0
            ? rBitMask
            : null,
        gBitMask: pixelFormatFlags & DdsPixelFormatFlags.rgb != 0x0 ||
                pixelFormatFlags & DdsPixelFormatFlags.yuv != 0x0
            ? gBitMask
            : null,
        bBitMask: pixelFormatFlags & DdsPixelFormatFlags.rgb != 0x0 ||
                pixelFormatFlags & DdsPixelFormatFlags.yuv != 0x0
            ? bBitMask
            : null,
        aBitMask: pixelFormatFlags & DdsPixelFormatFlags.alphaPixels != 0x0 ||
                pixelFormatFlags & DdsPixelFormatFlags.alpha != 0x0
            ? aBitMask
            : null,
      );

      final header = DdsHeader(
        flags: headerFlags,
        height: height,
        width: width,
        pitchOrLinearSize: pitchOrLinearSize,
        depth: headerFlags & DdsHeaderFlags.depth != 0x0 ? depth : null,
        mipMapCount: headerFlags & DdsHeaderFlags.mipMapCount != 0x0
            ? mipMapCount
            : null,
        pixelFormat: pixelFormat,
        caps: caps,
        caps2: caps2,
        caps3: caps3,
        caps4: caps4,
      );

      DdsHeaderDxt10? header10 = null;
      if (pixelFormat.fourCc == DdsD3dFormats.dx10) {
        if (dxgiFormat == null) {
          throw StateError('Invalid dxgi format');
        }

        if (resourceDimension == null) {
          throw StateError('Invalid resource dimension');
        }

        if (miscFlag == null) {
          throw StateError('Invalid misc flag');
        }

        if (arraySize == null) {
          throw StateError('Invalid array size');
        }

        if (miscFlags2 == null) {
          throw StateError('Invalid misc flags 2');
        }

        header10 = DdsHeaderDxt10(
          dxgiFormat: dxgiFormat,
          resourceDimension: resourceDimension,
          miscFlag: miscFlag,
          arraySize: arraySize,
          miscFlags2: miscFlags2,
        );
      }

      _sink.add(
        Dds(
          header: header,
          header10: header10,
          data: _data,
        ),
      );
    }

    _sink.close();
  }

  int _getUint32() {
    return _bytes.buffer.asByteData().getUint32(0, Endian.little);
  }
}
