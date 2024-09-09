import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as annotation;

class TgpcdxPaletteXmlConverter extends annotation.XmlConverter<dynamic> {
  const TgpcdxPaletteXmlConverter();

  @override
  void buildXmlChildren(
    dynamic instance,
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  }) {
    builder.element(
      'nil',
      namespace: namespaces['http://www.kuju.com/TnT/2003/Delta'],
      isSelfClosing: true,
    );
  }

  @override
  dynamic fromXmlElement(
    XmlElement element,
  ) {
    return null;
  }

  @override
  List<XmlAttribute> toXmlAttributes(
    dynamic instance, {
    Map<String, String?> namespaces = const {},
  }) {
    return [];
  }

  @override
  List<XmlNode> toXmlChildren(
    dynamic instance, {
    Map<String, String?> namespaces = const {},
  }) {
    return [
      XmlElement(
        XmlName(
          'nil',
          namespaces['http://www.kuju.com/TnT/2003/Delta'],
        ),
        [],
        [],
        true,
      ),
    ];
  }
}
