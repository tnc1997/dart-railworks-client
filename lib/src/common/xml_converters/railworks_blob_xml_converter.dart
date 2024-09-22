import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as annotation;

import '../constants/railworks_xml_namespaces.dart';
import '../converters/railworks_blob_decoder.dart';
import '../converters/railworks_blob_encoder.dart';

class RailWorksBlobXmlConverter implements annotation.XmlConverter<List<int>> {
  const RailWorksBlobXmlConverter();

  @override
  void buildXmlChildren(
    List<int> instance,
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  }) {
    builder.attribute(
      'size',
      instance.length.toString(),
      namespace: namespaces[RailWorksXmlNamespaces.delta],
    );

    builder.text(
      const RailWorksBlobDecoder().convert(instance),
    );
  }

  @override
  List<int> fromXmlElement(
    XmlElement element,
  ) {
    return const RailWorksBlobEncoder().convert(element.innerText);
  }

  @override
  List<XmlAttribute> toXmlAttributes(
    List<int> instance, {
    Map<String, String?> namespaces = const {},
  }) {
    return [
      XmlAttribute(
        XmlName(
          'size',
          namespaces[RailWorksXmlNamespaces.delta],
        ),
        instance.length.toString(),
      ),
    ];
  }

  @override
  List<XmlNode> toXmlChildren(
    List<int> instance, {
    Map<String, String?> namespaces = const {},
  }) {
    return [
      XmlText(
        const RailWorksBlobDecoder().convert(instance),
      ),
    ];
  }
}
