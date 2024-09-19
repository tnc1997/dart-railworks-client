import 'dart:convert';

import 'package:xml/xml.dart';

import '../../common/constants/railworks_xml_namespaces.dart';
import '../models/tgpcdx_chc_texture_group.dart';

/// A converter that encodes a [TgpcdxChcTextureGroup] to an [XmlDocument].
class XmlTgpcdxEncoder extends Converter<TgpcdxChcTextureGroup, XmlDocument> {
  static const _namespaces = {RailWorksXmlNamespaces.delta: 'd'};

  const XmlTgpcdxEncoder();

  @override
  XmlDocument convert(
    TgpcdxChcTextureGroup input,
  ) {
    return XmlDocument(
      [
        XmlDeclaration()
          ..version = '1.0'
          ..encoding = 'utf-8',
        input.toXmlElement(
          namespaces: _namespaces,
        ),
      ],
    );
  }

  @override
  Sink<TgpcdxChcTextureGroup> startChunkedConversion(
    Sink<XmlDocument> sink,
  ) {
    return _XmlTgpcdxEncoderSink(sink);
  }
}

class _XmlTgpcdxEncoderSink implements Sink<TgpcdxChcTextureGroup> {
  final Sink<XmlDocument> _sink;

  _XmlTgpcdxEncoderSink(this._sink);

  @override
  void add(
    TgpcdxChcTextureGroup data,
  ) {
    _sink.add(
      XmlDocument(
        [
          XmlDeclaration()
            ..version = '1.0'
            ..encoding = 'utf-8',
          data.toXmlElement(
            namespaces: XmlTgpcdxEncoder._namespaces,
          ),
        ],
      ),
    );
  }

  @override
  void close() {
    _sink.close();
  }
}
