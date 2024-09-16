import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:xml/xml.dart';

import '../../common/constants/railworks_data_types.dart';
import '../../common/constants/railworks_xml_namespaces.dart';
import '../../common/exceptions/railworks_data_type_invalid_exception.dart';
import 'bin_element.dart';

class BinValueElement extends BinElement {
  final String name;
  final String type;
  final Object value;

  const BinValueElement({
    required this.name,
    required this.type,
    required this.value,
  });

  @override
  int get hashCode {
    return name.hashCode ^ type.hashCode ^ value.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BinValueElement &&
            runtimeType == other.runtimeType &&
            name == other.name &&
            type == other.type &&
            value == other.value;
  }

  BinValueElement copyWith({
    String? name,
    String? type,
    Object? value,
  }) {
    return BinValueElement(
      name: name ?? this.name,
      type: type ?? this.type,
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
    final String value;

    if (type == RailWorksDataTypes.bool) {
      value = (this.value as bool) ? '1' : '0';
    } else if (type == RailWorksDataTypes.cDeltaString) {
      value = this.value as String;
    } else if (type == RailWorksDataTypes.sfloat32) {
      value = (this.value as double).toStringAsPrecision(6);
    } else if (type == RailWorksDataTypes.sint8 ||
        type == RailWorksDataTypes.sint16 ||
        type == RailWorksDataTypes.sint32 ||
        type == RailWorksDataTypes.sint64 ||
        type == RailWorksDataTypes.suint8 ||
        type == RailWorksDataTypes.suint16 ||
        type == RailWorksDataTypes.suint32 ||
        type == RailWorksDataTypes.suint64) {
      value = (this.value as int).toString();
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
            'type',
            namespaces[RailWorksXmlNamespaces.delta],
          ),
          type,
        ),
        if (type == RailWorksDataTypes.sfloat32)
          XmlAttribute(
            XmlName(
              'alt_encoding',
              namespaces[RailWorksXmlNamespaces.delta],
            ),
            hex.encode(
              Uint8List(8)
                ..buffer
                    .asByteData()
                    .setFloat64(0, value as double, Endian.little),
            ),
          ),
        if (type == RailWorksDataTypes.sfloat32)
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
