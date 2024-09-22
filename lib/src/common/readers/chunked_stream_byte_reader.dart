import 'dart:async';
import 'dart:typed_data';

import '../exceptions/railworks_end_of_stream_exception.dart';
import 'stream_byte_reader_base.dart';

class ChunkedStreamByteReader with StreamByteReaderBase {
  final StreamIterator<List<int>> _iterator;
  List<int> _buffer;
  int _offset;

  ChunkedStreamByteReader(
    Stream<List<int>> bytes,
  )   : _iterator = StreamIterator(bytes),
        _buffer = [],
        _offset = 0;

  @override
  Future<int> readByte() async {
    if (_buffer.length == _offset) {
      if (await _iterator.moveNext()) {
        _buffer = _iterator.current;
        _offset = 0;
      } else {
        throw RailWorksEndOfStreamException();
      }
    }

    return _buffer[_offset++];
  }

  @override
  Future<Uint8List> readBytes(
    int length,
  ) async {
    RangeError.checkNotNegative(length, 'length');

    final builder = BytesBuilder();

    while (length > 0) {
      if (_buffer.length == _offset) {
        if (await _iterator.moveNext()) {
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
