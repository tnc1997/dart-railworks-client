import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as annotation;

import '../../common/constants/railworks_xml_namespaces.dart';
import 'tgpcdx_texture.dart';

part 'tgpcdx_chc_texture_group.g.dart';

@annotation.XmlRootElement(
  name: 'cHcTextureGroup',
)
@annotation.XmlSerializable()
class TgpcdxChcTextureGroup {
  @annotation.XmlAttribute(
    name: 'version',
    namespace: RailWorksXmlNamespaces.delta,
  )
  final String version;

  @annotation.XmlAttribute(
    name: 'id',
    namespace: RailWorksXmlNamespaces.delta,
  )
  final int id;

  @annotation.XmlElement(
    name: 'Texture',
    isSelfClosing: false,
  )
  final TgpcdxTexture texture;

  const TgpcdxChcTextureGroup({
    this.version = '1.0',
    required this.id,
    required this.texture,
  });

  factory TgpcdxChcTextureGroup.fromXmlElement(
    XmlElement element,
  ) {
    return _$TgpcdxChcTextureGroupFromXmlElement(element);
  }

  void buildXmlChildren(
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  }) {
    _$TgpcdxChcTextureGroupBuildXmlChildren(
      this,
      builder,
      namespaces: namespaces,
    );
  }

  void buildXmlElement(
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  }) {
    _$TgpcdxChcTextureGroupBuildXmlElement(
      this,
      builder,
      namespaces: namespaces,
    );
  }

  List<XmlAttribute> toXmlAttributes({
    Map<String, String?> namespaces = const {},
  }) {
    return _$TgpcdxChcTextureGroupToXmlAttributes(
      this,
      namespaces: namespaces,
    );
  }

  List<XmlNode> toXmlChildren({
    Map<String, String?> namespaces = const {},
  }) {
    return _$TgpcdxChcTextureGroupToXmlChildren(
      this,
      namespaces: namespaces,
    );
  }

  XmlElement toXmlElement({
    Map<String, String?> namespaces = const {},
  }) {
    return _$TgpcdxChcTextureGroupToXmlElement(
      this,
      namespaces: namespaces,
    );
  }
}
