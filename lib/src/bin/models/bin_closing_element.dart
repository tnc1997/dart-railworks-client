import 'package:xml/xml.dart';

import 'bin_element.dart';

class BinClosingElement extends BinElement {
  final String name;

  const BinClosingElement({
    required this.name,
  });

  @override
  int get hashCode {
    return name.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BinClosingElement &&
            runtimeType == other.runtimeType &&
            name == other.name;
  }

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
