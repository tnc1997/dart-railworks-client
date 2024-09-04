import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as annotation;

abstract class TgpcdxTypedXmlConverter<T>
    implements annotation.XmlConverter<T> {
  final String type;

  const TgpcdxTypedXmlConverter({
    required this.type,
  });

  @override
  void buildXmlChildren(
    T instance,
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  }) {
    builder.attribute(
      'type',
      type,
      namespace: namespaces['http://www.kuju.com/TnT/2003/Delta'],
    );

    builder.text(
      serialize(instance),
    );
  }

  T deserialize(
    String text,
  );

  @override
  T fromXmlElement(
    XmlElement element,
  ) {
    return deserialize(element.innerText);
  }

  String serialize(
    T instance,
  );

  @override
  List<XmlAttribute> toXmlAttributes(
    T instance, {
    Map<String, String?> namespaces = const {},
  }) {
    return [
      XmlAttribute(
        XmlName(
          'type',
          namespaces['http://www.kuju.com/TnT/2003/Delta'],
        ),
        type,
      ),
    ];
  }

  @override
  List<XmlNode> toXmlChildren(
    T instance, {
    Map<String, String?> namespaces = const {},
  }) {
    return [
      XmlText(
        serialize(instance),
      ),
    ];
  }
}
