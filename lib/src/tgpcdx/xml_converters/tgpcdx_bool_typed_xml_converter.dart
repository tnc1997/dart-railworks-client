import 'tgpcdx_typed_xml_converter.dart';

class TgpcdxBoolTypedXmlConverter extends TgpcdxTypedXmlConverter<bool> {
  const TgpcdxBoolTypedXmlConverter()
      : super(
          type: 'bool',
        );

  @override
  bool deserialize(
    String text,
  ) {
    return text == '1';
  }

  @override
  String serialize(
    bool instance,
  ) {
    return instance ? '1' : '0';
  }
}
