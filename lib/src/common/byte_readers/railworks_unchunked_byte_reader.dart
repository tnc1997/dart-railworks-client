import 'dart:typed_data';

import '../exceptions/railworks_end_of_iterable_exception.dart';
import 'railworks_byte_reader_base.dart';

class RailWorksUnchunkedByteReader with RailWorksByteReaderBase {
  final Iterator<int> _iterator;

  RailWorksUnchunkedByteReader(
    Iterable<int> bytes,
  ) : _iterator = bytes.iterator;

  @override
  int readByte() {
    if (_iterator.moveNext()) {
      return _iterator.current;
    } else {
      throw RailWorksEndOfIterableException();
    }
  }

  @override
  Uint8List readBytes(
    int length,
  ) {
    RangeError.checkNotNegative(length, 'length');

    final builder = BytesBuilder();

    for (var i = 0; i < length; i++) {
      try {
        builder.addByte(readByte());
      } on RailWorksEndOfIterableException {
        break;
      }
    }

    return builder.takeBytes();
  }
}
