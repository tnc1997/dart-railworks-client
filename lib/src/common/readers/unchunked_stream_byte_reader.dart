import 'dart:async';
import 'dart:typed_data';

import '../exceptions/railworks_end_of_stream_exception.dart';
import 'stream_byte_reader_base.dart';

class UnchunkedStreamByteReader with StreamByteReaderBase {
  final StreamIterator<int> _iterator;

  UnchunkedStreamByteReader(
    Stream<int> bytes,
  ) : _iterator = StreamIterator(bytes);

  @override
  Future<int> readByte() async {
    if (await _iterator.moveNext()) {
      return _iterator.current;
    } else {
      throw RailWorksEndOfStreamException();
    }
  }

  @override
  Future<Uint8List> readBytes(
    int length,
  ) async {
    RangeError.checkNotNegative(length, 'length');

    final builder = BytesBuilder();

    for (var i = 0; i < length; i++) {
      try {
        builder.addByte(await readByte());
      } on RailWorksEndOfStreamException {
        break;
      }
    }

    return builder.takeBytes();
  }
}
