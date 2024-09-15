import 'package:xml/xml.dart';

import 'bin_element.dart';

class BinClosingElement extends BinElement {
  final String name;

  const BinClosingElement({
    required this.name,
  });

  BinClosingElement copyWith({
    String? name,
  }) {
    return BinClosingElement(
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return '</$name>';
  }

  @override
  XmlElement toXmlElement({
    Map<String, String?> namespaces = const {},
  }) {
    throw UnsupportedError('Invalid element type');
  }
}
