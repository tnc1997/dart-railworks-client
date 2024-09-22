import 'railworks_value_xml_converter.dart';

class RailWorksIntValueXmlConverter extends RailWorksValueXmlConverter<int> {
  const RailWorksIntValueXmlConverter({
    required String type,
  }) : super(
          type: type,
        );

  @override
  int deserialize(
    String innerText,
  ) {
    return int.parse(innerText);
  }

  @override
  String serialize(
    int instance,
  ) {
    return instance.toString();
  }
}

class RailWorksSuint8ValueXmlConverter extends RailWorksIntValueXmlConverter {
  const RailWorksSuint8ValueXmlConverter()
      : super(
          type: 'sUInt8',
        );
}

class RailWorksSuint16ValueXmlConverter extends RailWorksIntValueXmlConverter {
  const RailWorksSuint16ValueXmlConverter()
      : super(
          type: 'sUInt16',
        );
}

class RailWorksSuint32ValueXmlConverter extends RailWorksIntValueXmlConverter {
  const RailWorksSuint32ValueXmlConverter()
      : super(
          type: 'sUInt32',
        );
}

class RailWorksSuint64ValueXmlConverter extends RailWorksIntValueXmlConverter {
  const RailWorksSuint64ValueXmlConverter()
      : super(
          type: 'sUInt64',
        );
}
