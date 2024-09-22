import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as annotation;

import '../constants/railworks_xml_namespaces.dart';

abstract class RailWorksValueXmlConverter<T>
    implements annotation.XmlConverter<T> {
  final String type;

  const RailWorksValueXmlConverter({
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
      namespace: namespaces[RailWorksXmlNamespaces.delta],
    );

    builder.text(
      serialize(instance),
    );
  }

  T deserialize(
    String innerText,
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
          namespaces[RailWorksXmlNamespaces.delta],
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
