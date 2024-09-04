import 'dart:typed_data';

import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as annotation;

class TgpcdxBlobXmlConverter implements annotation.XmlConverter<List<int>> {
  const TgpcdxBlobXmlConverter();

  @override
  void buildXmlChildren(
    List<int> instance,
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  }) {
    builder.attribute(
      'size',
      instance.length.toString(),
      namespace: namespaces['http://www.kuju.com/TnT/2003/Delta'],
    );

    final buffer = StringBuffer();

    for (var i = 0; i < instance.length; i++) {
      if (i != 0 && i % 32 == 0) {
        buffer.write('\n');
      } else if (i != 0 && i % 8 == 0) {
        buffer.write(' ');
      }

      buffer.write(
        instance[i].toRadixString(16).padLeft(2, '0'),
      );
    }

    builder.text(
      buffer.toString(),
    );
  }

  @override
  List<int> fromXmlElement(
    XmlElement element,
  ) {
    final innerText = element.innerText.replaceAll(RegExp(r'\s+'), '');

    final data = Uint8List(innerText.length ~/ 2);

    for (var i = 0; i < innerText.length; i += 2) {
      data[i ~/ 2] = int.parse(
        '${innerText[i]}${innerText[i + 1]}',
        radix: 16,
      );
    }

    return data;
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
          namespaces['http://www.kuju.com/TnT/2003/Delta'],
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
    final buffer = StringBuffer();

    for (var i = 0; i < instance.length; i++) {
      if (i != 0 && i % 32 == 0) {
        buffer.write('\n');
      } else if (i != 0 && i % 8 == 0) {
        buffer.write(' ');
      }

      buffer.write(
        instance[i].toRadixString(16).padLeft(2, '0'),
      );
    }

    return [
      XmlText(
        buffer.toString(),
      ),
    ];
  }
}
