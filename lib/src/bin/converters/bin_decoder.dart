import 'dart:convert';
import 'dart:typed_data';

import 'package:xml/xml.dart';

import '../../common/constants/railworks_xml_namespaces.dart';
import '../iterators/bin_uint8_list_iterator.dart';
import '../models/bin_closing_element.dart';
import '../models/bin_opening_element.dart';

/// A converter that decodes bytes to an [XmlDocument].
class BinDecoder extends Converter<List<int>, XmlDocument> {
  static const _namespaces = {RailWorksXmlNamespaces.delta: 'd'};
  static const _prelude = [0x53, 0x45, 0x52, 0x5a, 0x00, 0x00, 0x01, 0x00];

  const BinDecoder();

  @override
  XmlDocument convert(
    List<int> input,
  ) {
    final iterator = BinUint8ListIterator(
      input is Uint8List ? input : Uint8List.fromList(input),
    );

    for (final byte in _prelude) {
      if (!iterator.moveNext() || iterator.current != byte) {
        throw Exception('Invalid prelude');
      }
    }

    if (!iterator.moveNext()) {
      throw Exception('Invalid input');
    }

    XmlElement? parentElement;

    while (true) {
      final element = iterator.readElement();

      if (element is BinOpeningElement) {
        final childElement = XmlElement(
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
        );

        parentElement?.children.add(childElement);

        parentElement = childElement;
      } else if (element is BinClosingElement) {
        if (parentElement?.parentElement == null) {
          break;
        }

        parentElement = parentElement?.parentElement;
      } else {
        parentElement?.children.add(
          element.toXmlElement(
            namespaces: _namespaces,
          ),
        );
      }
    }

    if (parentElement == null) {
      throw Exception('Invalid input');
    }

    return XmlDocument(
      [
        XmlDeclaration()
          ..version = '1.0'
          ..encoding = 'utf-8',
        parentElement
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
