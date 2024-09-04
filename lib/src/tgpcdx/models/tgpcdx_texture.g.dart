// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tgpcdx_texture.dart';

// **************************************************************************
// XmlSerializableGenerator
// **************************************************************************

void _$TgpcdxTextureBuildXmlChildren(TgpcdxTexture instance, XmlBuilder builder,
    {Map<String, String> namespaces = const {}}) {
  final chcTexture = instance.chcTexture;
  final chcTextureSerialized = chcTexture;
  builder.element('cHcTexture', isSelfClosing: false, nest: () {
    chcTextureSerialized.buildXmlChildren(builder, namespaces: namespaces);
  });
}

void _$TgpcdxTextureBuildXmlElement(TgpcdxTexture instance, XmlBuilder builder,
    {Map<String, String> namespaces = const {}}) {
  builder.element('Texture', namespaces: namespaces, nest: () {
    instance.buildXmlChildren(builder, namespaces: namespaces);
  });
}

TgpcdxTexture _$TgpcdxTextureFromXmlElement(XmlElement element) {
  final chcTexture = element.getElement('cHcTexture')!;
  return TgpcdxTexture(chcTexture: TgpcdxChcTexture.fromXmlElement(chcTexture));
}

List<XmlAttribute> _$TgpcdxTextureToXmlAttributes(TgpcdxTexture instance,
    {Map<String, String?> namespaces = const {}}) {
  final attributes = <XmlAttribute>[];
  return attributes;
}

List<XmlNode> _$TgpcdxTextureToXmlChildren(TgpcdxTexture instance,
    {Map<String, String?> namespaces = const {}}) {
  final children = <XmlNode>[];
  final chcTexture = instance.chcTexture;
  final chcTextureSerialized = chcTexture;
  final chcTextureConstructed = XmlElement(
      XmlName('cHcTexture'),
      chcTextureSerialized.toXmlAttributes(namespaces: namespaces),
      chcTextureSerialized.toXmlChildren(namespaces: namespaces),
      false);
  children.add(chcTextureConstructed);
  return children;
}

XmlElement _$TgpcdxTextureToXmlElement(TgpcdxTexture instance,
    {Map<String, String?> namespaces = const {}}) {
  return XmlElement(
      XmlName('Texture'),
      [
        ...namespaces.toXmlAttributes(),
        ...instance.toXmlAttributes(namespaces: namespaces)
      ],
      instance.toXmlChildren(namespaces: namespaces));
}
