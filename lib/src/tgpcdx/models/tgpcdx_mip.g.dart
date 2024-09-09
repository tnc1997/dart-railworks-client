// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tgpcdx_mip.dart';

// **************************************************************************
// XmlSerializableGenerator
// **************************************************************************

void _$TgpcdxMipBuildXmlChildren(TgpcdxMip instance, XmlBuilder builder,
    {Map<String, String> namespaces = const {}}) {
  final chcImageDxs = instance.chcImageDxs;
  final chcImageDxsSerialized = chcImageDxs;
  for (final value in chcImageDxsSerialized) {
    builder.element('cHcImageDx', isSelfClosing: false, nest: () {
      value.buildXmlChildren(builder, namespaces: namespaces);
    });
  }
}

void _$TgpcdxMipBuildXmlElement(TgpcdxMip instance, XmlBuilder builder,
    {Map<String, String> namespaces = const {}}) {
  builder.element('Mip', namespaces: namespaces, nest: () {
    instance.buildXmlChildren(builder, namespaces: namespaces);
  });
}

TgpcdxMip _$TgpcdxMipFromXmlElement(XmlElement element) {
  final chcImageDxs = element.getElements('cHcImageDx')!;
  return TgpcdxMip(
      chcImageDxs:
          chcImageDxs.map((e) => TgpcdxChcImageDx.fromXmlElement(e)).toList());
}

List<XmlAttribute> _$TgpcdxMipToXmlAttributes(TgpcdxMip instance,
    {Map<String, String?> namespaces = const {}}) {
  final attributes = <XmlAttribute>[];
  return attributes;
}

List<XmlNode> _$TgpcdxMipToXmlChildren(TgpcdxMip instance,
    {Map<String, String?> namespaces = const {}}) {
  final children = <XmlNode>[];
  final chcImageDxs = instance.chcImageDxs;
  final chcImageDxsSerialized = chcImageDxs;
  final chcImageDxsConstructed = chcImageDxsSerialized.map((e) => XmlElement(
      XmlName('cHcImageDx'),
      e.toXmlAttributes(namespaces: namespaces),
      e.toXmlChildren(namespaces: namespaces),
      false));
  children.addAll(chcImageDxsConstructed);
  return children;
}

XmlElement _$TgpcdxMipToXmlElement(TgpcdxMip instance,
    {Map<String, String?> namespaces = const {}}) {
  return XmlElement(
      XmlName('Mip'),
      [
        ...namespaces.toXmlAttributes(),
        ...instance.toXmlAttributes(namespaces: namespaces)
      ],
      instance.toXmlChildren(namespaces: namespaces));
}
