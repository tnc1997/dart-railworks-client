import 'package:xml/xml.dart';

abstract class BinElement {
  const BinElement();

  XmlElement toXmlElement({
    Map<String, String?> namespaces = const {},
  });
}
