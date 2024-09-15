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
