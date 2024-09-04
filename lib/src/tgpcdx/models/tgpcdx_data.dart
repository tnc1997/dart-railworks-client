import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as annotation;

import 'tgpcdx_chc_texture_data.dart';

part 'tgpcdx_data.g.dart';

@annotation.XmlRootElement(
  name: 'Data',
)
@annotation.XmlSerializable()
class TgpcdxData {
  @annotation.XmlElement(
    name: 'cHcTextureData',
    isSelfClosing: false,
  )
  final TgpcdxChcTextureData chcTextureData;

  const TgpcdxData({
    required this.chcTextureData,
  });

  factory TgpcdxData.fromXmlElement(
    XmlElement element,
  ) {
    return _$TgpcdxDataFromXmlElement(element);
  }

  void buildXmlChildren(
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  }) {
    _$TgpcdxDataBuildXmlChildren(
      this,
      builder,
      namespaces: namespaces,
    );
  }

  void buildXmlElement(
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  }) {
    _$TgpcdxDataBuildXmlElement(
      this,
      builder,
      namespaces: namespaces,
    );
  }

  List<XmlAttribute> toXmlAttributes({
    Map<String, String?> namespaces = const {},
  }) {
    return _$TgpcdxDataToXmlAttributes(
      this,
      namespaces: namespaces,
    );
  }

  List<XmlNode> toXmlChildren({
    Map<String, String?> namespaces = const {},
  }) {
    return _$TgpcdxDataToXmlChildren(
      this,
      namespaces: namespaces,
    );
  }

  XmlElement toXmlElement({
    Map<String, String?> namespaces = const {},
  }) {
    return _$TgpcdxDataToXmlElement(
      this,
      namespaces: namespaces,
    );
  }
}
