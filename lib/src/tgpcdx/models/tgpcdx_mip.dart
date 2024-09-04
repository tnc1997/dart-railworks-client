import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as annotation;

import 'tgpcdx_chc_image_dx.dart';

part 'tgpcdx_mip.g.dart';

@annotation.XmlRootElement(
  name: 'Mip',
)
@annotation.XmlSerializable()
class TgpcdxMip {
  @annotation.XmlElement(
    name: 'cHcImageDx',
    isSelfClosing: false,
  )
  final List<TgpcdxChcImageDx> chcImageDxs;

  const TgpcdxMip({
    required this.chcImageDxs,
  });

  factory TgpcdxMip.fromXmlElement(
    XmlElement element,
  ) {
    return _$TgpcdxMipFromXmlElement(element);
  }

  void buildXmlChildren(
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  }) {
    _$TgpcdxMipBuildXmlChildren(
      this,
      builder,
      namespaces: namespaces,
    );
  }

  void buildXmlElement(
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  }) {
    _$TgpcdxMipBuildXmlElement(
      this,
      builder,
      namespaces: namespaces,
    );
  }

  List<XmlAttribute> toXmlAttributes({
    Map<String, String?> namespaces = const {},
  }) {
    return _$TgpcdxMipToXmlAttributes(
      this,
      namespaces: namespaces,
    );
  }

  List<XmlNode> toXmlChildren({
    Map<String, String?> namespaces = const {},
  }) {
    return _$TgpcdxMipToXmlChildren(
      this,
      namespaces: namespaces,
    );
  }

  XmlElement toXmlElement({
    Map<String, String?> namespaces = const {},
  }) {
    return _$TgpcdxMipToXmlElement(
      this,
      namespaces: namespaces,
    );
  }
}
