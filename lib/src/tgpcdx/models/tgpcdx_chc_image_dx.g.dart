// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tgpcdx_chc_image_dx.dart';

// **************************************************************************
// XmlSerializableGenerator
// **************************************************************************

void _$TgpcdxChcImageDxBuildXmlChildren(
    TgpcdxChcImageDx instance, XmlBuilder builder,
    {Map<String, String> namespaces = const {}}) {
  final id = instance.id;
  final idSerialized = id.toString();
  builder.attribute('id', idSerialized,
      namespace: 'http://www.kuju.com/TnT/2003/Delta');
  final format = instance.format;
  final formatSerialized = format;
  builder.element('Format', isSelfClosing: false, nest: () {
    const RailWorksStringValueXmlConverter()
        .buildXmlChildren(formatSerialized, builder, namespaces: namespaces);
  });
  final isSwizzled = instance.isSwizzled;
  final isSwizzledSerialized = isSwizzled;
  builder.element('IsSwizzled', isSelfClosing: false, nest: () {
    const RailWorksBoolValueXmlConverter().buildXmlChildren(
        isSwizzledSerialized, builder,
        namespaces: namespaces);
  });
  final width = instance.width;
  final widthSerialized = width;
  builder.element('Width', isSelfClosing: false, nest: () {
    const RailWorksSuint16ValueXmlConverter()
        .buildXmlChildren(widthSerialized, builder, namespaces: namespaces);
  });
  final height = instance.height;
  final heightSerialized = height;
  builder.element('Height', isSelfClosing: false, nest: () {
    const RailWorksSuint16ValueXmlConverter()
        .buildXmlChildren(heightSerialized, builder, namespaces: namespaces);
  });
  final blob = instance.blob;
  final blobSerialized = blob;
  builder.element('blob',
      namespace: 'http://www.kuju.com/TnT/2003/Delta',
      isSelfClosing: true, nest: () {
    const RailWorksBlobXmlConverter()
        .buildXmlChildren(blobSerialized, builder, namespaces: namespaces);
  });
}

void _$TgpcdxChcImageDxBuildXmlElement(
    TgpcdxChcImageDx instance, XmlBuilder builder,
    {Map<String, String> namespaces = const {}}) {
  builder.element('cHcImageDx', namespaces: namespaces, nest: () {
    instance.buildXmlChildren(builder, namespaces: namespaces);
  });
}

TgpcdxChcImageDx _$TgpcdxChcImageDxFromXmlElement(XmlElement element) {
  final id = element.getAttribute('id',
      namespace: 'http://www.kuju.com/TnT/2003/Delta')!;
  final format = element.getElement('Format')!;
  final isSwizzled = element.getElement('IsSwizzled')!;
  final width = element.getElement('Width')!;
  final height = element.getElement('Height')!;
  final blob = element.getElement('blob',
      namespace: 'http://www.kuju.com/TnT/2003/Delta')!;
  return TgpcdxChcImageDx(
      id: int.parse(id),
      format: const RailWorksStringValueXmlConverter().fromXmlElement(format),
      isSwizzled:
          const RailWorksBoolValueXmlConverter().fromXmlElement(isSwizzled),
      width: const RailWorksSuint16ValueXmlConverter().fromXmlElement(width),
      height: const RailWorksSuint16ValueXmlConverter().fromXmlElement(height),
      blob: const RailWorksBlobXmlConverter().fromXmlElement(blob));
}

List<XmlAttribute> _$TgpcdxChcImageDxToXmlAttributes(TgpcdxChcImageDx instance,
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

List<XmlNode> _$TgpcdxChcImageDxToXmlChildren(TgpcdxChcImageDx instance,
    {Map<String, String?> namespaces = const {}}) {
  final children = <XmlNode>[];
  final format = instance.format;
  final formatSerialized = format;
  final formatConstructed = XmlElement(
      XmlName('Format'),
      const RailWorksStringValueXmlConverter()
          .toXmlAttributes(formatSerialized, namespaces: namespaces),
      const RailWorksStringValueXmlConverter()
          .toXmlChildren(formatSerialized, namespaces: namespaces),
      false);
  children.add(formatConstructed);
  final isSwizzled = instance.isSwizzled;
  final isSwizzledSerialized = isSwizzled;
  final isSwizzledConstructed = XmlElement(
      XmlName('IsSwizzled'),
      const RailWorksBoolValueXmlConverter()
          .toXmlAttributes(isSwizzledSerialized, namespaces: namespaces),
      const RailWorksBoolValueXmlConverter()
          .toXmlChildren(isSwizzledSerialized, namespaces: namespaces),
      false);
  children.add(isSwizzledConstructed);
  final width = instance.width;
  final widthSerialized = width;
  final widthConstructed = XmlElement(
      XmlName('Width'),
      const RailWorksSuint16ValueXmlConverter()
          .toXmlAttributes(widthSerialized, namespaces: namespaces),
      const RailWorksSuint16ValueXmlConverter()
          .toXmlChildren(widthSerialized, namespaces: namespaces),
      false);
  children.add(widthConstructed);
  final height = instance.height;
  final heightSerialized = height;
  final heightConstructed = XmlElement(
      XmlName('Height'),
      const RailWorksSuint16ValueXmlConverter()
          .toXmlAttributes(heightSerialized, namespaces: namespaces),
      const RailWorksSuint16ValueXmlConverter()
          .toXmlChildren(heightSerialized, namespaces: namespaces),
      false);
  children.add(heightConstructed);
  final blob = instance.blob;
  final blobSerialized = blob;
  final blobConstructed = XmlElement(
      XmlName('blob', namespaces['http://www.kuju.com/TnT/2003/Delta']),
      const RailWorksBlobXmlConverter()
          .toXmlAttributes(blobSerialized, namespaces: namespaces),
      const RailWorksBlobXmlConverter()
          .toXmlChildren(blobSerialized, namespaces: namespaces),
      true);
  children.add(blobConstructed);
  return children;
}

XmlElement _$TgpcdxChcImageDxToXmlElement(TgpcdxChcImageDx instance,
    {Map<String, String?> namespaces = const {}}) {
  return XmlElement(
      XmlName('cHcImageDx'),
      [
        ...namespaces.toXmlAttributes(),
        ...instance.toXmlAttributes(namespaces: namespaces)
      ],
      instance.toXmlChildren(namespaces: namespaces));
}
