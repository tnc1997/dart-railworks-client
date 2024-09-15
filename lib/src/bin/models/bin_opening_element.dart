import 'package:xml/xml.dart';

import 'bin_element.dart';

class BinOpeningElement extends BinElement {
  final String name;
  final int id;
  final int numChildren;

  const BinOpeningElement({
    required this.name,
    required this.id,
    required this.numChildren,
  });

  BinOpeningElement copyWith({
    String? name,
    int? id,
    int? numChildren,
  }) {
    return BinOpeningElement(
      name: name ?? this.name,
      id: id ?? this.id,
      numChildren: numChildren ?? this.numChildren,
    );
  }

  @override
  String toString() {
    final buffer = StringBuffer();

    buffer.write('<$name');

    if (id != 0) {
      buffer.write(' d:id="$id"');
    }

    buffer.write('>');

    return buffer.toString();
  }

  @override
  XmlElement toXmlElement({
    Map<String, String?> namespaces = const {},
  }) {
    throw UnsupportedError('Invalid element type');
  }
}
