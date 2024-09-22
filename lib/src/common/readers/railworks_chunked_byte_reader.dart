import 'dart:typed_data';

import '../exceptions/railworks_end_of_iterable_exception.dart';
import 'railworks_byte_reader_base.dart';

class RailWorksChunkedByteReader with RailWorksByteReaderBase {
  final Iterator<List<int>> _iterator;
  List<int> _buffer;
  int _offset;

  RailWorksChunkedByteReader(
    Iterable<List<int>> bytes,
  )   : _iterator = bytes.iterator,
        _buffer = [],
        _offset = 0;

  @override
  int readByte() {
    if (_buffer.length == _offset) {
      if (_iterator.moveNext()) {
        _buffer = _iterator.current;
        _offset = 0;
      } else {
        throw RailWorksEndOfIterableException();
      }
    }

    return _buffer[_offset++];
  }

  @override
  Uint8List readBytes(
    int length,
  ) {
    RangeError.checkNotNegative(length, 'length');

    final builder = BytesBuilder();

    while (length > 0) {
      if (_buffer.length == _offset) {
        if (_iterator.moveNext()) {
          _buffer = _iterator.current;
          _offset = 0;
        } else {
          break;
        }
      }

      if (_buffer.length > _offset) {
        if (_buffer.length - _offset >= length) {
          builder.add(_buffer.sublist(_offset, _offset + length));
          _offset += length;
          break;
        } else {
          builder.add(_buffer.sublist(_offset));
          length -= _buffer.length - _offset;
          _buffer.clear();
          _offset = 0;
        }
      }
    }

    return builder.takeBytes();
  }
}
