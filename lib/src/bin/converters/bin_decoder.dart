import 'dart:async';
import 'dart:convert';

import 'package:xml/xml.dart';

import '../../common/constants/railworks_xml_namespaces.dart';
import '../exceptions/bin_element_invalid_exception.dart';
import '../exceptions/bin_prelude_invalid_exception.dart';
import '../models/bin_closing_element.dart';
import '../models/bin_opening_element.dart';
import '../models/bin_undefined_element.dart';
import '../readers/bin_byte_reader.dart';
import '../readers/bin_stream_byte_reader.dart';
import '../readers/bin_unchunked_byte_reader.dart';

const _namespaces = {RailWorksXmlNamespaces.delta: 'd'};

/// A converter that decodes bytes to an [XmlDocument].
class BinDecoder extends Converter<List<int>, XmlDocument> {
  const BinDecoder();

  @override
  XmlDocument convert(
    List<int> input,
  ) {
    final reader = BinUnchunkedByteReader(input)..readPrelude();

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

  @override
  Sink<List<int>> startChunkedConversion(
    Sink<XmlDocument> sink,
  ) {
    return ByteConversionSink.withCallback(
      (accumulated) {
        sink.add(convert(accumulated));
      },
    );
  }
}

extension on BinByteReader {
  List<int> readPrelude() {
    const _prelude = [0x53, 0x45, 0x52, 0x5a, 0x00, 0x00, 0x01, 0x00];

    for (var i = 0; i < _prelude.length; i++) {
      if (readByte() != _prelude[i]) {
        throw BinPreludeInvalidException(null, i);
      }
    }

    return _prelude;
  }

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

extension on BinStreamByteReader {
  Future<List<int>> readPrelude() async {
    const _prelude = [0x53, 0x45, 0x52, 0x5a, 0x00, 0x00, 0x01, 0x00];

    for (var i = 0; i < _prelude.length; i++) {
      if (await readByte() != _prelude[i]) {
        throw BinPreludeInvalidException(null, i);
      }
    }

    return _prelude;
  }

  Future<List<XmlNode>> readXmlChildren() async {
    final children = <XmlNode>[];

    while (true) {
      final element = await readElement();

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
            await readXmlChildren(),
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

  Future<XmlElement> readXmlElement() async {
    while (true) {
      final element = await readElement();

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
          await readXmlChildren(),
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
