import 'package:xml/xml.dart';

import '../../common/constants/railworks_xml_namespaces.dart';
import 'bin_element.dart';

class BinNullElement extends BinElement {
  const BinNullElement();

  BinNullElement copyWith() {
    return const BinNullElement();
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
        'nil',
        namespaces[RailWorksXmlNamespaces.delta],
      ),
      [],
      [],
      true,
    );
  }
}
