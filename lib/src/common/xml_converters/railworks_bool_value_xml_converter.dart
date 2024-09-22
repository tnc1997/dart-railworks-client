import 'railworks_value_xml_converter.dart';

class RailWorksBoolValueXmlConverter extends RailWorksValueXmlConverter<bool> {
  const RailWorksBoolValueXmlConverter()
      : super(
          type: 'bool',
        );

  @override
  bool deserialize(
    String innerText,
  ) {
    return innerText == '1';
  }

  @override
  String serialize(
    bool instance,
  ) {
    return instance ? '1' : '0';
  }
}
