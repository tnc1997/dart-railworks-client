import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as annotation;

class TgpcdxPalette {
  const TgpcdxPalette();

  factory TgpcdxPalette.fromXmlElement(
    XmlElement element,
  ) {
    return const TgpcdxPalette();
  }

  void buildXmlChildren(
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  }) {
    builder.element(
      'nil',
      namespace: namespaces['http://www.kuju.com/TnT/2003/Delta'],
      isSelfClosing: true,
    );
  }

  void buildXmlElement(
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  }) {
    builder.element(
      'Palette',
      namespaces: namespaces,
      nest: () {
        buildXmlChildren(
          builder,
          namespaces: namespaces,
        );
      },
    );
  }

  List<XmlAttribute> toXmlAttributes({
    Map<String, String?> namespaces = const {},
  }) {
    return [];
  }

  List<XmlNode> toXmlChildren({
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

  XmlElement toXmlElement({
    Map<String, String?> namespaces = const {},
  }) {
    return XmlElement(
      XmlName('Palette'),
      [
        ...namespaces.toXmlAttributes(),
        ...toXmlAttributes(
          namespaces: namespaces,
        )
      ],
      toXmlChildren(
        namespaces: namespaces,
      ),
    );
  }
}
