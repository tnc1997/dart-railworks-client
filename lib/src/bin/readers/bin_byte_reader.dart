import 'dart:convert';
import 'dart:typed_data';

import '../../common/constants/railworks_data_types.dart';
import '../../common/exceptions/railworks_data_type_invalid_exception.dart';
import '../../common/iterables/circular_buffer.dart';
import '../../common/readers/byte_reader.dart';
import '../exceptions/bin_element_invalid_exception.dart';
import '../models/bin_blob_element.dart';
import '../models/bin_closing_element.dart';
import '../models/bin_element.dart';
import '../models/bin_matrix_element.dart';
import '../models/bin_null_element.dart';
import '../models/bin_opening_element.dart';
import '../models/bin_reference_element.dart';
import '../models/bin_undefined_element.dart';
import '../models/bin_value_element.dart';

class BinByteReader extends ByteReader {
  final _elements = CircularBuffer<BinElement>(0xff);
  final _strings = CircularBuffer<String>(0xffff);

  BinByteReader(
    List<int> bytes,
  ) : super(bytes);

  BinBlobElement readBlobElement() {
    final size = readUint32(Endian.little);
    final bytes = readBytes(size);

    final element = BinBlobElement(
      size: size,
      bytes: bytes,
    );

    _elements.add(element);

    return element;
  }

  BinBlobElement readCachedBlobElement(
    int index,
  ) {
    final element = _elements[index] as BinBlobElement;

    final size = readUint32(Endian.little);
    final bytes = readBytes(size);

    return element.copyWith(
      size: size,
      bytes: bytes,
    );
  }

  BinClosingElement readCachedClosingElement(
    int index,
  ) {
    final element = _elements[index] as BinClosingElement;

    return element.copyWith();
  }

  BinElement readCachedElement(
    int index,
  ) {
    final element = _elements[index] as BinElement;

    if (element is BinMatrixElement) {
      return readCachedMatrixElement(index);
    } else if (element is BinBlobElement) {
      return readCachedBlobElement(index);
    } else if (element is BinNullElement) {
      return readCachedNullElement(index);
    } else if (element is BinOpeningElement) {
      return readCachedOpeningElement(index);
    } else if (element is BinReferenceElement) {
      return readCachedReferenceElement(index);
    } else if (element is BinValueElement) {
      return readCachedValueElement(index);
    } else if (element is BinClosingElement) {
      return readCachedClosingElement(index);
    } else {
      throw BinElementInvalidException(null, element);
    }
  }

  BinMatrixElement readCachedMatrixElement(
    int index,
  ) {
    final element = _elements[index] as BinMatrixElement;

    final numElements = readByte();

    final elements = <Object>[];
    for (var i = 0; i < numElements; i++) {
      elements.add(readValue(element.elementType));
    }

    return element.copyWith(
      numElements: numElements,
      elements: elements,
    );
  }

  BinNullElement readCachedNullElement(
    int index,
  ) {
    final element = _elements[index] as BinNullElement;

    return element.copyWith();
  }

  BinOpeningElement readCachedOpeningElement(
    int index,
  ) {
    final element = _elements[index] as BinOpeningElement;

    final id = readUint32(Endian.little);
    final numChildren = readUint32(Endian.little);

    return element.copyWith(
      id: id,
      numChildren: numChildren,
    );
  }

  BinReferenceElement readCachedReferenceElement(
    int index,
  ) {
    final element = _elements[index] as BinReferenceElement;

    final value = readUint32(Endian.little);

    return element.copyWith(
      value: value,
    );
  }

  BinValueElement readCachedValueElement(
    int index,
  ) {
    final element = _elements[index] as BinValueElement;

    final value = readValue(element.type);

    return element.copyWith(
      value: value,
    );
  }

  BinClosingElement readClosingElement() {
    final name = readString();

    final element = BinClosingElement(
      name: name,
    );

    _elements.add(element);

    return element;
  }

  BinElement readElement() {
    final index = readByte();

    if (index == 0xff) {
      final type = readByte();

      if (type == 0x41) {
        return readMatrixElement();
      } else if (type == 0x42) {
        return readBlobElement();
      } else if (type == 0x43) {
        return readUndefinedElement(5);
      } else if (type == 0x4e) {
        return readNullElement();
      } else if (type == 0x50) {
        return readOpeningElement();
      } else if (type == 0x52) {
        return readReferenceElement();
      } else if (type == 0x56) {
        return readValueElement();
      } else if (type == 0x70) {
        return readClosingElement();
      } else {
        throw BinElementInvalidException();
      }
    }

    return readCachedElement(index);
  }

  BinMatrixElement readMatrixElement() {
    final name = readString();
    final elementType = readString();
    final numElements = readByte();

    final elements = <Object>[];
    for (var i = 0; i < numElements; i++) {
      elements.add(readValue(elementType));
    }

    final element = BinMatrixElement(
      name: name,
      elementType: elementType,
      numElements: numElements,
      elements: elements,
    );

    _elements.add(element);

    return element;
  }

  BinNullElement readNullElement() {
    final element = const BinNullElement();

    _elements.add(element);

    return element;
  }

  BinOpeningElement readOpeningElement() {
    final name = readString();
    final id = readUint32(Endian.little);
    final numChildren = readUint32(Endian.little);

    final element = BinOpeningElement(
      name: name,
      id: id,
      numChildren: numChildren,
    );

    _elements.add(element);

    return element;
  }

  BinReferenceElement readReferenceElement() {
    final name = readString();
    final value = readUint32(Endian.little);

    final element = BinReferenceElement(
      name: name,
      value: value,
    );

    _elements.add(element);

    return element;
  }

  BinUndefinedElement readUndefinedElement(
    int length,
  ) {
    final bytes = readBytes(length);

    final element = BinUndefinedElement(
      bytes: bytes,
    );

    _elements.add(element);

    return element;
  }

  String readString() {
    final index = readUint16(Endian.little);

    if (index == 0xffff) {
      final length = readUint32(Endian.little);
      final codeUnits = readBytes(length);

      final string = utf8.decode(codeUnits).replaceAll('::', '-');

      _strings.add(string);

      return string;
    } else {
      return _strings[index];
    }
  }

  Object readValue(
    String dataType,
  ) {
    switch (dataType) {
      case RailWorksDataTypes.bool:
        return readBool();
      case RailWorksDataTypes.cDeltaString:
        return readString();
      case RailWorksDataTypes.sfloat32:
        return readFloat32(Endian.little);
      case RailWorksDataTypes.sint8:
        return readInt8();
      case RailWorksDataTypes.sint16:
        return readInt16(Endian.little);
      case RailWorksDataTypes.sint32:
        return readInt32(Endian.little);
      case RailWorksDataTypes.sint64:
        return readInt64(Endian.little);
      case RailWorksDataTypes.suint8:
        return readUint8();
      case RailWorksDataTypes.suint16:
        return readUint16(Endian.little);
      case RailWorksDataTypes.suint32:
        return readUint32(Endian.little);
      case RailWorksDataTypes.suint64:
        return readUint64(Endian.little);
      default:
        throw RailWorksDataTypeInvalidException();
    }
  }

  BinValueElement readValueElement() {
    final name = readString();
    final type = readString();
    final value = readValue(type);

    final element = BinValueElement(
      name: name,
      type: type,
      value: value,
    );

    _elements.add(element);

    return element;
  }
}
