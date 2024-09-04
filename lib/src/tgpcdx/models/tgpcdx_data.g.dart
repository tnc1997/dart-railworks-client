// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tgpcdx_data.dart';

// **************************************************************************
// XmlSerializableGenerator
// **************************************************************************

void _$TgpcdxDataBuildXmlChildren(TgpcdxData instance, XmlBuilder builder,
    {Map<String, String> namespaces = const {}}) {
  final chcTextureData = instance.chcTextureData;
  final chcTextureDataSerialized = chcTextureData;
  builder.element('cHcTextureData', isSelfClosing: false, nest: () {
    chcTextureDataSerialized.buildXmlChildren(builder, namespaces: namespaces);
  });
}

void _$TgpcdxDataBuildXmlElement(TgpcdxData instance, XmlBuilder builder,
    {Map<String, String> namespaces = const {}}) {
  builder.element('Data', namespaces: namespaces, nest: () {
    instance.buildXmlChildren(builder, namespaces: namespaces);
  });
}

TgpcdxData _$TgpcdxDataFromXmlElement(XmlElement element) {
  final chcTextureData = element.getElement('cHcTextureData')!;
  return TgpcdxData(
      chcTextureData: TgpcdxChcTextureData.fromXmlElement(chcTextureData));
}

List<XmlAttribute> _$TgpcdxDataToXmlAttributes(TgpcdxData instance,
    {Map<String, String?> namespaces = const {}}) {
  final attributes = <XmlAttribute>[];
  return attributes;
}

List<XmlNode> _$TgpcdxDataToXmlChildren(TgpcdxData instance,
    {Map<String, String?> namespaces = const {}}) {
  final children = <XmlNode>[];
  final chcTextureData = instance.chcTextureData;
  final chcTextureDataSerialized = chcTextureData;
  final chcTextureDataConstructed = XmlElement(
      XmlName('cHcTextureData'),
      chcTextureDataSerialized.toXmlAttributes(namespaces: namespaces),
      chcTextureDataSerialized.toXmlChildren(namespaces: namespaces),
      false);
  children.add(chcTextureDataConstructed);
  return children;
}

XmlElement _$TgpcdxDataToXmlElement(TgpcdxData instance,
    {Map<String, String?> namespaces = const {}}) {
  return XmlElement(
      XmlName('Data'),
      [
        ...namespaces.toXmlAttributes(),
        ...instance.toXmlAttributes(namespaces: namespaces)
      ],
      instance.toXmlChildren(namespaces: namespaces));
}
