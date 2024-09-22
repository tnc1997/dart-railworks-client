import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as annotation;

import '../../common/constants/railworks_xml_namespaces.dart';

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
      namespace: namespaces[RailWorksXmlNamespaces.delta],
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
          namespaces[RailWorksXmlNamespaces.delta],
        ),
        [],
        [],
        true,
      ),
    ];
  }
}
