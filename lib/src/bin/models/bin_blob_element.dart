import 'package:collection/collection.dart';
import 'package:xml/xml.dart';

import '../../common/constants/railworks_xml_namespaces.dart';
import 'bin_element.dart';

class BinBlobElement extends BinElement {
  final int size;
  final List<int> bytes;

  const BinBlobElement({
    required this.size,
    required this.bytes,
  });

  @override
  int get hashCode {
    return size.hashCode ^ const ListEquality<int>().hash(bytes);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BinBlobElement &&
            runtimeType == other.runtimeType &&
            size == other.size &&
            const ListEquality<int>().equals(bytes, other.bytes);
  }

  BinBlobElement copyWith({
    int? size,
    List<int>? bytes,
  }) {
    return BinBlobElement(
      size: size ?? this.size,
      bytes: bytes ?? this.bytes,
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
    final buffer = StringBuffer();

    for (var i = 0; i < bytes.length; i++) {
      if (i != 0 && i % 32 == 0) {
        buffer.write('\n');
      } else if (i != 0 && i % 8 == 0) {
        buffer.write(' ');
      }

      buffer.write(
        bytes[i].toRadixString(16).padLeft(2, '0'),
      );
    }

    return XmlElement(
      XmlName(
        'blob',
        namespaces[RailWorksXmlNamespaces.delta],
      ),
      [
        XmlAttribute(
          XmlName(
            'size',
            namespaces[RailWorksXmlNamespaces.delta],
          ),
          size.toString(),
        ),
      ],
      [
        XmlText(
          buffer.toString(),
        ),
      ],
      false,
    );
  }
}
