import 'railworks_value_xml_converter.dart';

class RailWorksStringValueXmlConverter
    extends RailWorksValueXmlConverter<String> {
  const RailWorksStringValueXmlConverter()
      : super(
          type: 'cDeltaString',
        );

  @override
  String deserialize(
    String innerText,
  ) {
    return innerText;
  }

  @override
  String serialize(
    String instance,
  ) {
    return instance;
  }
}
