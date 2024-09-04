import 'tgpcdx_typed_xml_converter.dart';

class TgpcdxIntTypedXmlConverter extends TgpcdxTypedXmlConverter<int> {
  const TgpcdxIntTypedXmlConverter({
    required String type,
  }) : super(
          type: type,
        );

  @override
  int deserialize(
    String text,
  ) {
    return int.parse(text);
  }

  @override
  String serialize(
    int instance,
  ) {
    return instance.toString();
  }
}

class TgpcdxSuint16TypedXmlConverter extends TgpcdxIntTypedXmlConverter {
  const TgpcdxSuint16TypedXmlConverter()
      : super(
          type: 'sUInt16',
        );
}

class TgpcdxSuint32TypedXmlConverter extends TgpcdxIntTypedXmlConverter {
  const TgpcdxSuint32TypedXmlConverter()
      : super(
          type: 'sUInt32',
        );
}
