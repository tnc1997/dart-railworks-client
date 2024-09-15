import 'package:xml/xml.dart';

import '../../common/constants/railworks_xml_namespaces.dart';
import 'bin_element.dart';

class BinReferenceElement extends BinElement {
  final String name;
  final int value;

  const BinReferenceElement({
    required this.name,
    required this.value,
  });

  @override
  int get hashCode {
    return name.hashCode ^ value.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BinReferenceElement &&
            runtimeType == other.runtimeType &&
            name == other.name &&
            value == other.value;
  }

  BinReferenceElement copyWith({
    String? name,
    int? value,
  }) {
    return BinReferenceElement(
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  @override
  String toString() {
    return toXmlElement().toString();
  }

  @override
  XmlElement toXmlElement({
    Map<String, String?> namespaces = const {},
  }) {
    return XmlElement(
      XmlName(
        name,
      ),
      [
        XmlAttribute(
          XmlName(
            'type',
            namespaces[RailWorksXmlNamespaces.delta],
          ),
          'ref',
        ),
      ],
      [
        XmlText(
          value.toString(),
        ),
      ],
      false,
    );
  }
}
