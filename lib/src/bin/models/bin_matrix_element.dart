import 'package:collection/collection.dart';
import 'package:xml/xml.dart';

import '../../common/constants/railworks_data_types.dart';
import '../../common/constants/railworks_xml_namespaces.dart';
import '../../common/exceptions/railworks_data_type_invalid_exception.dart';
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
    final String value;

    if (elementType == RailWorksDataTypes.bool) {
      value = elements.cast<bool>().map((value) {
        return value ? '1' : '0';
      }).join(' ');
    } else if (elementType == RailWorksDataTypes.cDeltaString) {
      value = elements.cast<String>().join(' ');
    } else if (elementType == RailWorksDataTypes.sfloat32) {
      value = elements.cast<double>().map((value) {
        return value.toStringAsFixed(7);
      }).join(' ');
    } else if (elementType == RailWorksDataTypes.sint8 ||
        elementType == RailWorksDataTypes.sint16 ||
        elementType == RailWorksDataTypes.sint32 ||
        elementType == RailWorksDataTypes.sint64 ||
        elementType == RailWorksDataTypes.suint8 ||
        elementType == RailWorksDataTypes.suint16 ||
        elementType == RailWorksDataTypes.suint32 ||
        elementType == RailWorksDataTypes.suint64) {
      value = elements.cast<int>().map((value) {
        return value.toString();
      }).join(' ');
    } else {
      throw RailWorksDataTypeInvalidException();
    }

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
        XmlText(
          value,
        ),
      ],
      false,
    );
  }
}
