// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tgpcdx_chc_image_dx.dart';

// **************************************************************************
// XmlSerializableGenerator
// **************************************************************************

void _$TgpcdxChcImageDxBuildXmlChildren(
    TgpcdxChcImageDx instance, XmlBuilder builder,
    {Map<String, String> namespaces = const {}}) {
  final blob = instance.blob;
  final blobSerialized = blob;
  builder.element('blob',
      namespace: 'http://www.kuju.com/TnT/2003/Delta',
      isSelfClosing: true, nest: () {
    const TgpcdxBlobXmlConverter()
        .buildXmlChildren(blobSerialized, builder, namespaces: namespaces);
  });
  final format = instance.format;
  final formatSerialized = format;
  builder.element('Format', isSelfClosing: false, nest: () {
    const TgpcdxStringTypedXmlConverter()
        .buildXmlChildren(formatSerialized, builder, namespaces: namespaces);
  });
  final height = instance.height;
  final heightSerialized = height;
  builder.element('Height', isSelfClosing: false, nest: () {
    const TgpcdxSuint16TypedXmlConverter()
        .buildXmlChildren(heightSerialized, builder, namespaces: namespaces);
  });
  final id = instance.id;
  final idSerialized = id.toString();
  builder.attribute('id', idSerialized,
      namespace: 'http://www.kuju.com/TnT/2003/Delta');
  final isSwizzled = instance.isSwizzled;
  final isSwizzledSerialized = isSwizzled;
  builder.element('IsSwizzled', isSelfClosing: false, nest: () {
    const TgpcdxBoolTypedXmlConverter().buildXmlChildren(
        isSwizzledSerialized, builder,
        namespaces: namespaces);
  });
  final width = instance.width;
  final widthSerialized = width;
  builder.element('Width', isSelfClosing: false, nest: () {
    const TgpcdxSuint16TypedXmlConverter()
        .buildXmlChildren(widthSerialized, builder, namespaces: namespaces);
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
  final blob = element.getElement('blob',
      namespace: 'http://www.kuju.com/TnT/2003/Delta')!;
  final format = element.getElement('Format')!;
  final height = element.getElement('Height')!;
  final id = element.getAttribute('id',
      namespace: 'http://www.kuju.com/TnT/2003/Delta')!;
  final isSwizzled = element.getElement('IsSwizzled')!;
  final width = element.getElement('Width')!;
  return TgpcdxChcImageDx(
      blob: const TgpcdxBlobXmlConverter().fromXmlElement(blob),
      format: const TgpcdxStringTypedXmlConverter().fromXmlElement(format),
      height: const TgpcdxSuint16TypedXmlConverter().fromXmlElement(height),
      id: int.parse(id),
      isSwizzled:
          const TgpcdxBoolTypedXmlConverter().fromXmlElement(isSwizzled),
      width: const TgpcdxSuint16TypedXmlConverter().fromXmlElement(width));
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
  final blob = instance.blob;
  final blobSerialized = blob;
  final blobConstructed = XmlElement(
      XmlName('blob', namespaces['http://www.kuju.com/TnT/2003/Delta']),
      const TgpcdxBlobXmlConverter()
          .toXmlAttributes(blobSerialized, namespaces: namespaces),
      const TgpcdxBlobXmlConverter()
          .toXmlChildren(blobSerialized, namespaces: namespaces),
      true);
  children.add(blobConstructed);
  final format = instance.format;
  final formatSerialized = format;
  final formatConstructed = XmlElement(
      XmlName('Format'),
      const TgpcdxStringTypedXmlConverter()
          .toXmlAttributes(formatSerialized, namespaces: namespaces),
      const TgpcdxStringTypedXmlConverter()
          .toXmlChildren(formatSerialized, namespaces: namespaces),
      false);
  children.add(formatConstructed);
  final height = instance.height;
  final heightSerialized = height;
  final heightConstructed = XmlElement(
      XmlName('Height'),
      const TgpcdxSuint16TypedXmlConverter()
          .toXmlAttributes(heightSerialized, namespaces: namespaces),
      const TgpcdxSuint16TypedXmlConverter()
          .toXmlChildren(heightSerialized, namespaces: namespaces),
      false);
  children.add(heightConstructed);
  final isSwizzled = instance.isSwizzled;
  final isSwizzledSerialized = isSwizzled;
  final isSwizzledConstructed = XmlElement(
      XmlName('IsSwizzled'),
      const TgpcdxBoolTypedXmlConverter()
          .toXmlAttributes(isSwizzledSerialized, namespaces: namespaces),
      const TgpcdxBoolTypedXmlConverter()
          .toXmlChildren(isSwizzledSerialized, namespaces: namespaces),
      false);
  children.add(isSwizzledConstructed);
  final width = instance.width;
  final widthSerialized = width;
  final widthConstructed = XmlElement(
      XmlName('Width'),
      const TgpcdxSuint16TypedXmlConverter()
          .toXmlAttributes(widthSerialized, namespaces: namespaces),
      const TgpcdxSuint16TypedXmlConverter()
          .toXmlChildren(widthSerialized, namespaces: namespaces),
      false);
  children.add(widthConstructed);
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
