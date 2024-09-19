import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as annotation;

import '../../common/constants/railworks_xml_namespaces.dart';
import '../xml_converters/tgpcdx_palette_xml_converter.dart';
import 'tgpcdx_mip.dart';

part 'tgpcdx_chc_texture_data.g.dart';

@annotation.XmlRootElement(
  name: 'cHcTextureData',
)
@annotation.XmlSerializable()
class TgpcdxChcTextureData {
  @annotation.XmlAttribute(
    name: 'id',
    namespace: RailWorksXmlNamespaces.delta,
  )
  final int id;

  @annotation.XmlElement(
    name: 'Mip',
    isSelfClosing: false,
  )
  final TgpcdxMip mip;

  @TgpcdxPaletteXmlConverter()
  @annotation.XmlElement(
    name: 'Palette',
    isSelfClosing: false,
  )
  final dynamic palette;

  const TgpcdxChcTextureData({
    required this.id,
    required this.mip,
    required this.palette,
  });

  factory TgpcdxChcTextureData.fromXmlElement(
    XmlElement element,
  ) {
    return _$TgpcdxChcTextureDataFromXmlElement(element);
  }

  void buildXmlChildren(
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  }) {
    _$TgpcdxChcTextureDataBuildXmlChildren(
      this,
      builder,
      namespaces: namespaces,
    );
  }

  void buildXmlElement(
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  }) {
    _$TgpcdxChcTextureDataBuildXmlElement(
      this,
      builder,
      namespaces: namespaces,
    );
  }

  List<XmlAttribute> toXmlAttributes({
    Map<String, String?> namespaces = const {},
  }) {
    return _$TgpcdxChcTextureDataToXmlAttributes(
      this,
      namespaces: namespaces,
    );
  }

  List<XmlNode> toXmlChildren({
    Map<String, String?> namespaces = const {},
  }) {
    return _$TgpcdxChcTextureDataToXmlChildren(
      this,
      namespaces: namespaces,
    );
  }

  XmlElement toXmlElement({
    Map<String, String?> namespaces = const {},
  }) {
    return _$TgpcdxChcTextureDataToXmlElement(
      this,
      namespaces: namespaces,
    );
  }
}
