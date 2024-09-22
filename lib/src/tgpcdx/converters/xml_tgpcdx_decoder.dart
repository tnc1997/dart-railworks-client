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
}
