import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as annotation;

import 'tgpcdx_chc_texture.dart';

part 'tgpcdx_texture.g.dart';

@annotation.XmlRootElement(
  name: 'Texture',
)
@annotation.XmlSerializable()
class TgpcdxTexture {
  @annotation.XmlElement(
    name: 'cHcTexture',
    isSelfClosing: false,
  )
  final TgpcdxChcTexture chcTexture;

  const TgpcdxTexture({
    required this.chcTexture,
  });

  factory TgpcdxTexture.fromXmlElement(
    XmlElement element,
  ) {
    return _$TgpcdxTextureFromXmlElement(element);
  }

  void buildXmlChildren(
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  }) {
    _$TgpcdxTextureBuildXmlChildren(
      this,
      builder,
      namespaces: namespaces,
    );
  }

  void buildXmlElement(
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  }) {
    _$TgpcdxTextureBuildXmlElement(
      this,
      builder,
      namespaces: namespaces,
    );
  }

  List<XmlAttribute> toXmlAttributes({
    Map<String, String?> namespaces = const {},
  }) {
    return _$TgpcdxTextureToXmlAttributes(
      this,
      namespaces: namespaces,
    );
  }

  List<XmlNode> toXmlChildren({
    Map<String, String?> namespaces = const {},
  }) {
    return _$TgpcdxTextureToXmlChildren(
      this,
      namespaces: namespaces,
    );
  }

  XmlElement toXmlElement({
    Map<String, String?> namespaces = const {},
  }) {
    return _$TgpcdxTextureToXmlElement(
      this,
      namespaces: namespaces,
    );
  }
}
