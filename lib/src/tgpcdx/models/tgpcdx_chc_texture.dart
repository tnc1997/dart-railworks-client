import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as annotation;

import '../../common/constants/railworks_xml_namespaces.dart';
import '../../common/xml_converters/railworks_int_value_xml_converter.dart';
import '../../common/xml_converters/railworks_string_value_xml_converter.dart';
import 'tgpcdx_data.dart';

part 'tgpcdx_chc_texture.g.dart';

@annotation.XmlRootElement(
  name: 'cHcTexture',
)
@annotation.XmlSerializable()
class TgpcdxChcTexture {
  @annotation.XmlAttribute(
    name: 'id',
    namespace: RailWorksXmlNamespaces.delta,
  )
  final int id;

  @annotation.XmlElement(
    name: 'Width',
    isSelfClosing: false,
  )
  @RailWorksSuint32ValueXmlConverter()
  final int width;

  @annotation.XmlElement(
    name: 'Height',
    isSelfClosing: false,
  )
  @RailWorksSuint32ValueXmlConverter()
  final int height;

  @annotation.XmlElement(
    name: 'Name',
    isSelfClosing: false,
  )
  @RailWorksStringValueXmlConverter()
  final String name;

  @annotation.XmlElement(
    name: 'Data',
    isSelfClosing: false,
  )
  final TgpcdxData data;

  const TgpcdxChcTexture({
    required this.id,
    required this.width,
    required this.height,
    required this.name,
    required this.data,
  });

  factory TgpcdxChcTexture.fromXmlElement(
    XmlElement element,
  ) {
    return _$TgpcdxChcTextureFromXmlElement(element);
  }

  void buildXmlChildren(
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  }) {
    _$TgpcdxChcTextureBuildXmlChildren(
      this,
      builder,
      namespaces: namespaces,
    );
  }

  void buildXmlElement(
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  }) {
    _$TgpcdxChcTextureBuildXmlElement(
      this,
      builder,
      namespaces: namespaces,
    );
  }

  List<XmlAttribute> toXmlAttributes({
    Map<String, String?> namespaces = const {},
  }) {
    return _$TgpcdxChcTextureToXmlAttributes(
      this,
      namespaces: namespaces,
    );
  }

  List<XmlNode> toXmlChildren({
    Map<String, String?> namespaces = const {},
  }) {
    return _$TgpcdxChcTextureToXmlChildren(
      this,
      namespaces: namespaces,
    );
  }

  XmlElement toXmlElement({
    Map<String, String?> namespaces = const {},
  }) {
    return _$TgpcdxChcTextureToXmlElement(
      this,
      namespaces: namespaces,
    );
  }
}
