import 'dart:typed_data';

import 'package:xml/xml.dart';

import '../../common/constants/railworks_data_types.dart';
import '../../common/constants/railworks_xml_namespaces.dart';
import '../../common/exceptions/railworks_data_type_invalid_exception.dart';
import '../exceptions/xml_element_invalid_exception.dart';
import 'bin_blob_element.dart';
import 'bin_matrix_element.dart';
import 'bin_null_element.dart';
import 'bin_reference_element.dart';
import 'bin_value_element.dart';

abstract class BinElement {
  const BinElement();

  factory BinElement.fromXmlElement(
    XmlElement element,
  ) {
    final elementType = element.getAttribute(
      'elementType',
      namespace: RailWorksXmlNamespaces.delta,
    );

    final numElements = element.getAttribute(
      'numElements',
      namespace: RailWorksXmlNamespaces.delta,
    );

    final size = element.getAttribute(
      'size',
      namespace: RailWorksXmlNamespaces.delta,
    );

    final type = element.getAttribute(
      'type',
      namespace: RailWorksXmlNamespaces.delta,
    );

    if (element.name.local == 'blob' && size != null) {
      final innerText = element.innerText.replaceAll(RegExp(r'\s+'), '');

      final bytes = Uint8List(innerText.length ~/ 2);

      for (var i = 0; i < innerText.length; i += 2) {
        bytes[i ~/ 2] = int.parse(
          '${innerText[i]}${innerText[i + 1]}',
          radix: 16,
        );
      }

      return BinBlobElement(
        size: int.parse(size),
        bytes: bytes,
      );
    } else if (elementType != null && numElements != null) {
      final elements = <Object>[];

      for (final value in element.innerText.split(' ')) {
        if (type == RailWorksDataTypes.bool) {
          elements.add(value == '1');
        } else if (type == RailWorksDataTypes.cDeltaString) {
          elements.add(value);
        } else if (type == RailWorksDataTypes.sfloat32) {
          elements.add(double.parse(value));
        } else if (type == RailWorksDataTypes.sint8 ||
            type == RailWorksDataTypes.sint16 ||
            type == RailWorksDataTypes.sint32 ||
            type == RailWorksDataTypes.sint64 ||
            type == RailWorksDataTypes.suint8 ||
            type == RailWorksDataTypes.suint16 ||
            type == RailWorksDataTypes.suint32 ||
            type == RailWorksDataTypes.suint64) {
          elements.add(int.parse(value));
        } else {
          throw RailWorksDataTypeInvalidException();
        }
      }

      return BinMatrixElement(
        name: element.name.local,
        elementType: elementType,
        numElements: int.parse(numElements),
        elements: elements,
      );
    } else if (element.name.local == 'nil') {
      return const BinNullElement();
    } else if (type == 'ref') {
      return BinReferenceElement(
        name: element.name.local,
        value: int.parse(element.innerText),
      );
    } else if (type != null) {
      final Object value;

      if (type == RailWorksDataTypes.bool) {
        value = element.innerText == '1';
      } else if (type == RailWorksDataTypes.cDeltaString) {
        value = element.innerText;
      } else if (type == RailWorksDataTypes.sfloat32) {
        value = double.parse(element.innerText);
      } else if (type == RailWorksDataTypes.sint8 ||
          type == RailWorksDataTypes.sint16 ||
          type == RailWorksDataTypes.sint32 ||
          type == RailWorksDataTypes.sint64 ||
          type == RailWorksDataTypes.suint8 ||
          type == RailWorksDataTypes.suint16 ||
          type == RailWorksDataTypes.suint32 ||
          type == RailWorksDataTypes.suint64) {
        value = int.parse(element.innerText);
      } else {
        throw RailWorksDataTypeInvalidException();
      }

      return BinValueElement(
        name: element.name.local,
        type: type,
        value: value,
      );
    } else {
      throw XmlElementInvalidException(null, element);
    }
  }

  XmlElement toXmlElement({
    Map<String, String?> namespaces = const {},
  });
}
