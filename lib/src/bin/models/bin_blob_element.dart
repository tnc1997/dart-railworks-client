import 'package:collection/collection.dart';
import 'package:convert/convert.dart';
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
          hex.encode(bytes).slices(16).slices(4).map((values) {
            return values.join(' ');
          }).join('\n'),
        ),
      ],
      false,
    );
  }
}

extension on String {
  Iterable<String> slices(
    int length,
  ) sync* {
    for (final charCodes in codeUnits.slices(length)) {
      yield String.fromCharCodes(charCodes);
    }
  }
}
