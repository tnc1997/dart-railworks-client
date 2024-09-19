import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:xml/xml.dart';

import '../../common/constants/railworks_xml_namespaces.dart';
import '../models/bin_closing_element.dart';
import '../models/bin_element.dart';
import '../models/bin_opening_element.dart';
import '../writers/bin_byte_writer.dart';

/// A converter that encodes an [XmlDocument] to bytes.
class BinEncoder extends Converter<XmlDocument, List<int>> {
  static const _prelude = [0x53, 0x45, 0x52, 0x5a, 0x00, 0x00, 0x01, 0x00];

  const BinEncoder();

  @override
  List<int> convert(
    XmlDocument input,
  ) {
    final sink = ByteAccumulatorSink();

    final writer = BinByteWriter(sink);

    writer.writeBytes(_prelude);

    writer.writeXmlElement(input.rootElement);

    sink.close();

    return sink.bytes;
  }
}

extension on BinByteWriter {
  void writeXmlElement(
    XmlElement element,
  ) {
    final children = element.children.whereType<XmlElement>().toList();

    if (children.length > 0) {
      final id = element.getAttribute(
        'id',
        namespace: RailWorksXmlNamespaces.delta,
      );

      writeElement(
        BinOpeningElement(
          name: element.name.local,
          id: id != null ? int.parse(id) : 0,
          numChildren: children.length,
        ),
      );

      for (final child in children) {
        writeXmlElement(child);
      }

      writeElement(
        BinClosingElement(
          name: element.name.local,
        ),
      );
    } else {
      writeElement(
        BinElement.fromXmlElement(element),
      );
    }
  }
}
