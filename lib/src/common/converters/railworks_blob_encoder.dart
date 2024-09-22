import 'dart:convert';
import 'dart:typed_data';

import '../exceptions/railworks_blob_invalid_exception.dart';

/// A converter that encodes a blob to bytes.
class RailWorksBlobEncoder extends Converter<String, List<int>> {
  const RailWorksBlobEncoder();

  @override
  List<int> convert(
    String input,
  ) {
    final builder = BytesBuilder();

    for (var i = 0; i < input.length; i++) {
      if (input[i] == '\n' || input[i] == '\r' || input[i] == ' ') {
        continue;
      }

      if (i + 1 >= input.length) {
        throw RailWorksBlobInvalidException(
          'The blob contains an odd number of characters',
        );
      }

      final byte = int.tryParse(
        '${input[i]}${input[++i]}',
        radix: 16,
      );

      if (byte == null) {
        throw RailWorksBlobInvalidException(
          'The blob contains an invalid character',
        );
      }

      builder.addByte(byte);
    }

    return builder.takeBytes();
  }
}
