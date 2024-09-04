// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tgpcdx_chc_texture_group.dart';

// **************************************************************************
// XmlSerializableGenerator
// **************************************************************************

void _$TgpcdxChcTextureGroupBuildXmlChildren(
    TgpcdxChcTextureGroup instance, XmlBuilder builder,
    {Map<String, String> namespaces = const {}}) {
  final id = instance.id;
  final idSerialized = id.toString();
  builder.attribute('id', idSerialized,
      namespace: 'http://www.kuju.com/TnT/2003/Delta');
  final texture = instance.texture;
  final textureSerialized = texture;
  builder.element('Texture', isSelfClosing: false, nest: () {
    textureSerialized.buildXmlChildren(builder, namespaces: namespaces);
  });
  final version = instance.version;
  final versionSerialized = version;
  builder.attribute('version', versionSerialized,
      namespace: 'http://www.kuju.com/TnT/2003/Delta');
}

void _$TgpcdxChcTextureGroupBuildXmlElement(
    TgpcdxChcTextureGroup instance, XmlBuilder builder,
    {Map<String, String> namespaces = const {}}) {
  builder.element('cHcTextureGroup', namespaces: namespaces, nest: () {
    instance.buildXmlChildren(builder, namespaces: namespaces);
  });
}

TgpcdxChcTextureGroup _$TgpcdxChcTextureGroupFromXmlElement(
    XmlElement element) {
  final id = element.getAttribute('id',
      namespace: 'http://www.kuju.com/TnT/2003/Delta')!;
  final texture = element.getElement('Texture')!;
  final version = element.getAttribute('version',
      namespace: 'http://www.kuju.com/TnT/2003/Delta')!;
  return TgpcdxChcTextureGroup(
      id: int.parse(id),
      texture: TgpcdxTexture.fromXmlElement(texture),
      version: version);
}

List<XmlAttribute> _$TgpcdxChcTextureGroupToXmlAttributes(
    TgpcdxChcTextureGroup instance,
    {Map<String, String?> namespaces = const {}}) {
  final attributes = <XmlAttribute>[];
  final id = instance.id;
  final idSerialized = id.toString();
  final idConstructed = XmlAttribute(
      XmlName('id', namespaces['http://www.kuju.com/TnT/2003/Delta']),
      idSerialized);
  attributes.add(idConstructed);
  final version = instance.version;
  final versionSerialized = version;
  final versionConstructed = XmlAttribute(
      XmlName('version', namespaces['http://www.kuju.com/TnT/2003/Delta']),
      versionSerialized);
  attributes.add(versionConstructed);
  return attributes;
}

List<XmlNode> _$TgpcdxChcTextureGroupToXmlChildren(
    TgpcdxChcTextureGroup instance,
    {Map<String, String?> namespaces = const {}}) {
  final children = <XmlNode>[];
  final texture = instance.texture;
  final textureSerialized = texture;
  final textureConstructed = XmlElement(
      XmlName('Texture'),
      textureSerialized.toXmlAttributes(namespaces: namespaces),
      textureSerialized.toXmlChildren(namespaces: namespaces),
      false);
  children.add(textureConstructed);
  return children;
}

XmlElement _$TgpcdxChcTextureGroupToXmlElement(TgpcdxChcTextureGroup instance,
    {Map<String, String?> namespaces = const {}}) {
  return XmlElement(
      XmlName('cHcTextureGroup'),
      [
        ...namespaces.toXmlAttributes(),
        ...instance.toXmlAttributes(namespaces: namespaces)
      ],
      instance.toXmlChildren(namespaces: namespaces));
}
