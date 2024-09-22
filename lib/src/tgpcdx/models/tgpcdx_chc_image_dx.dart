import 'package:xml/xml.dart';
import 'package:xml_annotation/xml_annotation.dart' as annotation;

import '../../common/constants/railworks_xml_namespaces.dart';
import '../../common/xml_converters/railworks_blob_xml_converter.dart';
import '../../common/xml_converters/railworks_bool_value_xml_converter.dart';
import '../../common/xml_converters/railworks_int_value_xml_converter.dart';
import '../../common/xml_converters/railworks_string_value_xml_converter.dart';

part 'tgpcdx_chc_image_dx.g.dart';

@annotation.XmlRootElement(
  name: 'cHcImageDx',
)
@annotation.XmlSerializable()
class TgpcdxChcImageDx {
  @annotation.XmlAttribute(
    name: 'id',
    namespace: RailWorksXmlNamespaces.delta,
  )
  final int id;

  @annotation.XmlElement(
    name: 'Format',
    isSelfClosing: false,
  )
  @RailWorksStringValueXmlConverter()
  final String format;

  @annotation.XmlElement(
    name: 'IsSwizzled',
    isSelfClosing: false,
  )
  @RailWorksBoolValueXmlConverter()
  final bool isSwizzled;

  @annotation.XmlElement(
    name: 'Width',
    isSelfClosing: false,
  )
  @RailWorksSuint16ValueXmlConverter()
  final int width;

  @annotation.XmlElement(
    name: 'Height',
    isSelfClosing: false,
  )
  @RailWorksSuint16ValueXmlConverter()
  final int height;

  @annotation.XmlElement(
    name: 'blob',
    namespace: RailWorksXmlNamespaces.delta,
    isSelfClosing: true,
  )
  @RailWorksBlobXmlConverter()
  final List<int> blob;

  const TgpcdxChcImageDx({
    required this.id,
    required this.format,
    required this.isSwizzled,
    required this.width,
    required this.height,
    required this.blob,
  });

  factory TgpcdxChcImageDx.fromXmlElement(
    XmlElement element,
  ) {
    return _$TgpcdxChcImageDxFromXmlElement(element);
  }

  void buildXmlChildren(
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  }) {
    _$TgpcdxChcImageDxBuildXmlChildren(
      this,
      builder,
      namespaces: namespaces,
    );
  }

  void buildXmlElement(
    XmlBuilder builder, {
    Map<String, String> namespaces = const {},
  }) {
    _$TgpcdxChcImageDxBuildXmlElement(
      this,
      builder,
      namespaces: namespaces,
    );
  }

  List<XmlAttribute> toXmlAttributes({
    Map<String, String?> namespaces = const {},
  }) {
    return _$TgpcdxChcImageDxToXmlAttributes(
      this,
      namespaces: namespaces,
    );
  }

  List<XmlNode> toXmlChildren({
    Map<String, String?> namespaces = const {},
  }) {
    return _$TgpcdxChcImageDxToXmlChildren(
      this,
      namespaces: namespaces,
    );
  }

  XmlElement toXmlElement({
    Map<String, String?> namespaces = const {},
  }) {
    return _$TgpcdxChcImageDxToXmlElement(
      this,
      namespaces: namespaces,
    );
  }
}
