import 'package:collection/collection.dart';
import 'package:xml/xml.dart';

import '../../common/constants/railworks_data_types.dart';
import '../../common/constants/railworks_xml_namespaces.dart';
import 'bin_element.dart';

class BinMatrixElement extends BinElement {
  final String name;
  final String elementType;
  final int numElements;
  final List<Object> elements;

  const BinMatrixElement({
    required this.name,
    required this.elementType,
    required this.numElements,
    required this.elements,
  });

  @override
  int get hashCode {
    return name.hashCode ^
        elementType.hashCode ^
        numElements.hashCode ^
        const ListEquality<Object>().hash(elements);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BinMatrixElement &&
            runtimeType == other.runtimeType &&
            name == other.name &&
            elementType == other.elementType &&
            numElements == other.numElements &&
            const ListEquality<Object>().equals(elements, other.elements);
  }

  BinMatrixElement copyWith({
    String? name,
    String? elementType,
    int? numElements,
    List<Object>? elements,
  }) {
    return BinMatrixElement(
      name: name ?? this.name,
      elementType: elementType ?? this.elementType,
      numElements: numElements ?? this.numElements,
      elements: elements ?? this.elements,
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
            'numElements',
            namespaces[RailWorksXmlNamespaces.delta],
          ),
          numElements.toString(),
        ),
        XmlAttribute(
          XmlName(
            'elementType',
            namespaces[RailWorksXmlNamespaces.delta],
          ),
          elementType,
        ),
        if (elementType == RailWorksDataTypes.sfloat32)
          XmlAttribute(
            XmlName(
              'precision',
              namespaces[RailWorksXmlNamespaces.delta],
            ),
            'string',
          ),
      ],
      [
        if (elementType == RailWorksDataTypes.sfloat32)
          XmlText(
            elements.cast<double>().map((value) {
              return value.toStringAsFixed(7);
            }).join(' '),
          )
        else
          XmlText(
            elements.map((value) {
              return value.toString();
            }).join(' '),
          ),
      ],
      false,
    );
  }
}
