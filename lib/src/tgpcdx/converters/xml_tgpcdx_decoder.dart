import 'dart:convert';

import 'package:xml/xml.dart';

import '../models/tgpcdx_chc_texture_group.dart';

/// A converter that decodes an [XmlDocument] to a [TgpcdxChcTextureGroup].
class XmlTgpcdxDecoder extends Converter<XmlDocument, TgpcdxChcTextureGroup> {
  const XmlTgpcdxDecoder();

  @override
  TgpcdxChcTextureGroup convert(
    XmlDocument input,
  ) {
    return TgpcdxChcTextureGroup.fromXmlElement(input.rootElement);
  }

  @override
  Sink<XmlDocument> startChunkedConversion(
    Sink<TgpcdxChcTextureGroup> sink,
  ) {
    return _XmlTgpcdxDecoderSink(sink);
  }
}

class _XmlTgpcdxDecoderSink implements Sink<XmlDocument> {
  final Sink<TgpcdxChcTextureGroup> _sink;

  _XmlTgpcdxDecoderSink(this._sink);

  @override
  void add(
    XmlDocument data,
  ) {
    _sink.add(TgpcdxChcTextureGroup.fromXmlElement(data.rootElement));
  }

  @override
  void close() {
    _sink.close();
  }
}
