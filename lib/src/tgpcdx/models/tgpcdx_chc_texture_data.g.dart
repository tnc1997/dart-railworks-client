// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tgpcdx_chc_texture_data.dart';

// **************************************************************************
// XmlSerializableGenerator
// **************************************************************************

void _$TgpcdxChcTextureDataBuildXmlChildren(
    TgpcdxChcTextureData instance, XmlBuilder builder,
    {Map<String, String> namespaces = const {}}) {
  final id = instance.id;
  final idSerialized = id.toString();
  builder.attribute('id', idSerialized,
      namespace: 'http://www.kuju.com/TnT/2003/Delta');
  final mip = instance.mip;
  final mipSerialized = mip;
  builder.element('Mip', isSelfClosing: false, nest: () {
    mipSerialized.buildXmlChildren(builder, namespaces: namespaces);
  });
  final palette = instance.palette;
  final paletteSerialized = palette;
  builder.element('Palette', isSelfClosing: false, nest: () {
    paletteSerialized.buildXmlChildren(builder, namespaces: namespaces);
  });
}

void _$TgpcdxChcTextureDataBuildXmlElement(
    TgpcdxChcTextureData instance, XmlBuilder builder,
    {Map<String, String> namespaces = const {}}) {
  builder.element('cHcTextureData', namespaces: namespaces, nest: () {
    instance.buildXmlChildren(builder, namespaces: namespaces);
  });
}

TgpcdxChcTextureData _$TgpcdxChcTextureDataFromXmlElement(XmlElement element) {
  final id = element.getAttribute('id',
      namespace: 'http://www.kuju.com/TnT/2003/Delta')!;
  final mip = element.getElement('Mip')!;
  final palette = element.getElement('Palette')!;
  return TgpcdxChcTextureData(
      id: int.parse(id),
      mip: TgpcdxMip.fromXmlElement(mip),
      palette: TgpcdxPalette.fromXmlElement(palette));
}

List<XmlAttribute> _$TgpcdxChcTextureDataToXmlAttributes(
    TgpcdxChcTextureData instance,
    {Map<String, String?> namespaces = const {}}) {
  final attributes = <XmlAttribute>[];
  final id = instance.id;
  final idSerialized = id.toString();
  final idConstructed = XmlAttribute(
      XmlName('id', namespaces['http://www.kuju.com/TnT/2003/Delta']),
      idSerialized);
  attributes.add(idConstructed);
  return attributes;
}

List<XmlNode> _$TgpcdxChcTextureDataToXmlChildren(TgpcdxChcTextureData instance,
    {Map<String, String?> namespaces = const {}}) {
  final children = <XmlNode>[];
  final mip = instance.mip;
  final mipSerialized = mip;
  final mipConstructed = XmlElement(
      XmlName('Mip'),
      mipSerialized.toXmlAttributes(namespaces: namespaces),
      mipSerialized.toXmlChildren(namespaces: namespaces),
      false);
  children.add(mipConstructed);
  final palette = instance.palette;
  final paletteSerialized = palette;
  final paletteConstructed = XmlElement(
      XmlName('Palette'),
      paletteSerialized.toXmlAttributes(namespaces: namespaces),
      paletteSerialized.toXmlChildren(namespaces: namespaces),
      false);
  children.add(paletteConstructed);
  return children;
}

XmlElement _$TgpcdxChcTextureDataToXmlElement(TgpcdxChcTextureData instance,
    {Map<String, String?> namespaces = const {}}) {
  return XmlElement(
      XmlName('cHcTextureData'),
      [
        ...namespaces.toXmlAttributes(),
        ...instance.toXmlAttributes(namespaces: namespaces)
      ],
      instance.toXmlChildren(namespaces: namespaces));
}
