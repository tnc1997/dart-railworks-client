import 'package:xml/src/xml/nodes/element.dart';

import 'bin_element.dart';

class BinUndefinedElement extends BinElement {
  final List<int> bytes;

  const BinUndefinedElement({
    required this.bytes,
  });

  BinUndefinedElement copyWith({
    List<int>? bytes,
  }) {
    return BinUndefinedElement(
      bytes: bytes ?? this.bytes,
    );
  }

  @override
  XmlElement toXmlElement({
    Map<String, String?> namespaces = const {},
  }) {
    throw UnsupportedError('Invalid element type');
  }
}
