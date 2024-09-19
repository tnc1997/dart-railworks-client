import 'dart:convert';

import 'package:xml/xml.dart';

import '../../common/constants/railworks_xml_namespaces.dart';
import '../exceptions/bin_element_invalid_exception.dart';
import '../exceptions/bin_prelude_invalid_exception.dart';
import '../models/bin_closing_element.dart';
import '../models/bin_opening_element.dart';
import '../models/bin_undefined_element.dart';
import '../readers/bin_byte_reader.dart';

const _namespaces = {RailWorksXmlNamespaces.delta: 'd'};

/// A converter that decodes bytes to an [XmlDocument].
class BinDecoder extends Converter<List<int>, XmlDocument> {
  static const _prelude = [0x53, 0x45, 0x52, 0x5a, 0x00, 0x00, 0x01, 0x00];

  const BinDecoder();

  @override
  XmlDocument convert(
    List<int> input,
  ) {
    final reader = BinByteReader(input);

    for (var i = 0; i < _prelude.length; i++) {
      if (reader.readByte() != _prelude[i]) {
        throw BinPreludeInvalidException(null, i);
      }
    }

    return XmlDocument(
      [
        XmlDeclaration()
          ..version = '1.0'
          ..encoding = 'utf-8',
        reader.readXmlElement()
          ..attributes.add(
            XmlAttribute(
              XmlName(
                _namespaces[RailWorksXmlNamespaces.delta]!,
                'xmlns',
              ),
              RailWorksXmlNamespaces.delta,
            ),
          )
          ..attributes.add(
            XmlAttribute(
              XmlName(
                'version',
                _namespaces[RailWorksXmlNamespaces.delta],
              ),
              '1.0',
            ),
          ),
      ],
    );
  }
}

extension on BinByteReader {
  List<XmlNode> readXmlChildren() {
    final children = <XmlNode>[];

    while (true) {
      final element = readElement();

      if (element is BinClosingElement) {
        return children;
      } else if (element is BinOpeningElement) {
        children.add(
          XmlElement(
            XmlName(
              element.name,
            ),
            [
              if (element.id != 0)
                XmlAttribute(
                  XmlName(
                    'id',
                    _namespaces[RailWorksXmlNamespaces.delta],
                  ),
                  element.id.toString(),
                ),
            ],
            readXmlChildren(),
          ),
        );
      } else if (element is BinUndefinedElement) {
        continue;
      } else {
        children.add(
          element.toXmlElement(
            namespaces: _namespaces,
          ),
        );
      }
    }
  }

  XmlElement readXmlElement() {
    while (true) {
      final element = readElement();

      if (element is BinClosingElement) {
        throw BinElementInvalidException(null, element);
      } else if (element is BinOpeningElement) {
        return XmlElement(
          XmlName(
            element.name,
          ),
          [
            if (element.id != 0)
              XmlAttribute(
                XmlName(
                  'id',
                  _namespaces[RailWorksXmlNamespaces.delta],
                ),
                element.id.toString(),
              ),
          ],
          readXmlChildren(),
        );
      } else if (element is BinUndefinedElement) {
        continue;
      } else {
        return element.toXmlElement(
          namespaces: _namespaces,
        );
      }
    }
  }
}
