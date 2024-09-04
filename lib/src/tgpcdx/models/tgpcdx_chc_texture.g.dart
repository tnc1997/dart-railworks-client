// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tgpcdx_chc_texture.dart';

// **************************************************************************
// XmlSerializableGenerator
// **************************************************************************

void _$TgpcdxChcTextureBuildXmlChildren(
    TgpcdxChcTexture instance, XmlBuilder builder,
    {Map<String, String> namespaces = const {}}) {
  final data = instance.data;
  final dataSerialized = data;
  builder.element('Data', isSelfClosing: false, nest: () {
    dataSerialized.buildXmlChildren(builder, namespaces: namespaces);
  });
  final height = instance.height;
  final heightSerialized = height;
  builder.element('Height', isSelfClosing: false, nest: () {
    const TgpcdxSuint32TypedXmlConverter()
        .buildXmlChildren(heightSerialized, builder, namespaces: namespaces);
  });
  final id = instance.id;
  final idSerialized = id.toString();
  builder.attribute('id', idSerialized,
      namespace: 'http://www.kuju.com/TnT/2003/Delta');
  final name = instance.name;
  final nameSerialized = name;
  builder.element('Name', isSelfClosing: false, nest: () {
    const TgpcdxStringTypedXmlConverter()
        .buildXmlChildren(nameSerialized, builder, namespaces: namespaces);
  });
  final width = instance.width;
  final widthSerialized = width;
  builder.element('Width', isSelfClosing: false, nest: () {
    const TgpcdxSuint32TypedXmlConverter()
        .buildXmlChildren(widthSerialized, builder, namespaces: namespaces);
  });
}

void _$TgpcdxChcTextureBuildXmlElement(
    TgpcdxChcTexture instance, XmlBuilder builder,
    {Map<String, String> namespaces = const {}}) {
  builder.element('cHcTexture', namespaces: namespaces, nest: () {
    instance.buildXmlChildren(builder, namespaces: namespaces);
  });
}

TgpcdxChcTexture _$TgpcdxChcTextureFromXmlElement(XmlElement element) {
  final data = element.getElement('Data')!;
  final height = element.getElement('Height')!;
  final id = element.getAttribute('id',
      namespace: 'http://www.kuju.com/TnT/2003/Delta')!;
  final name = element.getElement('Name')!;
  final width = element.getElement('Width')!;
  return TgpcdxChcTexture(
      data: TgpcdxData.fromXmlElement(data),
      height: const TgpcdxSuint32TypedXmlConverter().fromXmlElement(height),
      id: int.parse(id),
      name: const TgpcdxStringTypedXmlConverter().fromXmlElement(name),
      width: const TgpcdxSuint32TypedXmlConverter().fromXmlElement(width));
}

List<XmlAttribute> _$TgpcdxChcTextureToXmlAttributes(TgpcdxChcTexture instance,
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

List<XmlNode> _$TgpcdxChcTextureToXmlChildren(TgpcdxChcTexture instance,
    {Map<String, String?> namespaces = const {}}) {
  final children = <XmlNode>[];
  final data = instance.data;
  final dataSerialized = data;
  final dataConstructed = XmlElement(
      XmlName('Data'),
      dataSerialized.toXmlAttributes(namespaces: namespaces),
      dataSerialized.toXmlChildren(namespaces: namespaces),
      false);
  children.add(dataConstructed);
  final height = instance.height;
  final heightSerialized = height;
  final heightConstructed = XmlElement(
      XmlName('Height'),
      const TgpcdxSuint32TypedXmlConverter()
          .toXmlAttributes(heightSerialized, namespaces: namespaces),
      const TgpcdxSuint32TypedXmlConverter()
          .toXmlChildren(heightSerialized, namespaces: namespaces),
      false);
  children.add(heightConstructed);
  final name = instance.name;
  final nameSerialized = name;
  final nameConstructed = XmlElement(
      XmlName('Name'),
      const TgpcdxStringTypedXmlConverter()
          .toXmlAttributes(nameSerialized, namespaces: namespaces),
      const TgpcdxStringTypedXmlConverter()
          .toXmlChildren(nameSerialized, namespaces: namespaces),
      false);
  children.add(nameConstructed);
  final width = instance.width;
  final widthSerialized = width;
  final widthConstructed = XmlElement(
      XmlName('Width'),
      const TgpcdxSuint32TypedXmlConverter()
          .toXmlAttributes(widthSerialized, namespaces: namespaces),
      const TgpcdxSuint32TypedXmlConverter()
          .toXmlChildren(widthSerialized, namespaces: namespaces),
      false);
  children.add(widthConstructed);
  return children;
}

XmlElement _$TgpcdxChcTextureToXmlElement(TgpcdxChcTexture instance,
    {Map<String, String?> namespaces = const {}}) {
  return XmlElement(
      XmlName('cHcTexture'),
      [
        ...namespaces.toXmlAttributes(),
        ...instance.toXmlAttributes(namespaces: namespaces)
      ],
      instance.toXmlChildren(namespaces: namespaces));
}
