import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:xml/xml.dart';

import '../../common/constants/railworks_xml_namespaces.dart';
import '../byte_writers/bin_byte_writer.dart';
import '../byte_writers/bin_chunked_byte_writer.dart';
import '../models/bin_closing_element.dart';
import '../models/bin_element.dart';
import '../models/bin_opening_element.dart';

/// A converter that encodes an [XmlDocument] to bytes.
class BinEncoder extends Converter<XmlDocument, List<int>> {
  const BinEncoder();

  @override
  List<int> convert(
    XmlDocument input,
  ) {
    final sink = ByteAccumulatorSink();

    BinChunkedByteWriter(sink)
      ..writePrelude()
      ..writeXmlElement(input.rootElement);

    sink.close();

    return sink.bytes;
  }

  @override
  Sink<XmlDocument> startChunkedConversion(
    Sink<List<int>> sink,
  ) {
    return _BinEncoderSink(sink);
  }
}

class _BinEncoderSink implements Sink<XmlDocument> {
  final Sink<List<int>> _sink;
  final BinByteWriter _writer;

  _BinEncoderSink(this._sink) : _writer = BinChunkedByteWriter(_sink);

  @override
  void add(
    XmlDocument data,
  ) {
    _writer
      ..writePrelude()
      ..writeXmlElement(data.rootElement);
  }

  @override
  void close() {
    _sink.close();
  }
}

extension on BinByteWriter {
  void writePrelude() {
    const prelude = [0x53, 0x45, 0x52, 0x5a, 0x00, 0x00, 0x01, 0x00];

    writeBytes(prelude);
  }

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
