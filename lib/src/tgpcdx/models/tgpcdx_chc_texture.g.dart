// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tgpcdx_chc_texture.dart';

// **************************************************************************
// XmlSerializableGenerator
// **************************************************************************

void _$TgpcdxChcTextureBuildXmlChildren(
    TgpcdxChcTexture instance, XmlBuilder builder,
    {Map<String, String> namespaces = const {}}) {
  final id = instance.id;
  final idSerialized = id.toString();
  builder.attribute('id', idSerialized,
      namespace: 'http://www.kuju.com/TnT/2003/Delta');
  final width = instance.width;
  final widthSerialized = width;
  builder.element('Width', isSelfClosing: false, nest: () {
    const RailWorksSuint32ValueXmlConverter()
        .buildXmlChildren(widthSerialized, builder, namespaces: namespaces);
  });
  final height = instance.height;
  final heightSerialized = height;
  builder.element('Height', isSelfClosing: false, nest: () {
    const RailWorksSuint32ValueXmlConverter()
        .buildXmlChildren(heightSerialized, builder, namespaces: namespaces);
  });
  final name = instance.name;
  final nameSerialized = name;
  builder.element('Name', isSelfClosing: false, nest: () {
    const RailWorksStringValueXmlConverter()
        .buildXmlChildren(nameSerialized, builder, namespaces: namespaces);
  });
  final data = instance.data;
  final dataSerialized = data;
  builder.element('Data', isSelfClosing: false, nest: () {
    dataSerialized.buildXmlChildren(builder, namespaces: namespaces);
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
  final id = element.getAttribute('id',
      namespace: 'http://www.kuju.com/TnT/2003/Delta')!;
  final width = element.getElement('Width')!;
  final height = element.getElement('Height')!;
  final name = element.getElement('Name')!;
  final data = element.getElement('Data')!;
  return TgpcdxChcTexture(
      id: int.parse(id),
      width: const RailWorksSuint32ValueXmlConverter().fromXmlElement(width),
      height: const RailWorksSuint32ValueXmlConverter().fromXmlElement(height),
      name: const RailWorksStringValueXmlConverter().fromXmlElement(name),
      data: TgpcdxData.fromXmlElement(data));
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
  final width = instance.width;
  final widthSerialized = width;
  final widthConstructed = XmlElement(
      XmlName('Width'),
      const RailWorksSuint32ValueXmlConverter()
          .toXmlAttributes(widthSerialized, namespaces: namespaces),
      const RailWorksSuint32ValueXmlConverter()
          .toXmlChildren(widthSerialized, namespaces: namespaces),
      false);
  children.add(widthConstructed);
  final height = instance.height;
  final heightSerialized = height;
  final heightConstructed = XmlElement(
      XmlName('Height'),
      const RailWorksSuint32ValueXmlConverter()
          .toXmlAttributes(heightSerialized, namespaces: namespaces),
      const RailWorksSuint32ValueXmlConverter()
          .toXmlChildren(heightSerialized, namespaces: namespaces),
      false);
  children.add(heightConstructed);
  final name = instance.name;
  final nameSerialized = name;
  final nameConstructed = XmlElement(
      XmlName('Name'),
      const RailWorksStringValueXmlConverter()
          .toXmlAttributes(nameSerialized, namespaces: namespaces),
      const RailWorksStringValueXmlConverter()
          .toXmlChildren(nameSerialized, namespaces: namespaces),
      false);
  children.add(nameConstructed);
  final data = instance.data;
  final dataSerialized = data;
  final dataConstructed = XmlElement(
      XmlName('Data'),
      dataSerialized.toXmlAttributes(namespaces: namespaces),
      dataSerialized.toXmlChildren(namespaces: namespaces),
      false);
  children.add(dataConstructed);
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
