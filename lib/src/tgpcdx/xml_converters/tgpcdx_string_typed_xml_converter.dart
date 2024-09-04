import 'tgpcdx_typed_xml_converter.dart';

class TgpcdxStringTypedXmlConverter extends TgpcdxTypedXmlConverter<String> {
  const TgpcdxStringTypedXmlConverter()
      : super(
          type: 'cDeltaString',
        );

  @override
  String deserialize(
    String text,
  ) {
    return text;
  }

  @override
  String serialize(
    String instance,
  ) {
    return instance;
  }
}
