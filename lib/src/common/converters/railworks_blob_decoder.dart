import 'dart:convert';

/// A converter that decodes bytes to a blob.
class RailWorksBlobDecoder extends Converter<List<int>, String> {
  const RailWorksBlobDecoder();

  @override
  String convert(
    List<int> input,
  ) {
    final buffer = StringBuffer();

    for (var i = 0; i < input.length; i++) {
      if (i != 0 && i % 32 == 0) {
        buffer.write('\n');
      } else if (i != 0 && i % 8 == 0) {
        buffer.write(' ');
      }

      buffer.write(
        input[i].toRadixString(16).padLeft(2, '0'),
      );
    }

    return buffer.toString();
  }
}
