import 'dart:convert';
import 'dart:typed_data';

import '../../common/constants/railworks_data_types.dart';
import '../../common/exceptions/railworks_data_type_invalid_exception.dart';
import '../../common/iterables/railworks_circular_buffer.dart';
import '../../common/readers/byte_reader_base.dart';
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
import 'bin_byte_reader.dart';

mixin BinByteReaderBase on ByteReaderBase implements BinByteReader {
  final _elements = RailWorksCircularBuffer<BinElement>(0xff);
  final _strings = RailWorksCircularBuffer<String>(0xffff);

  @override
  BinElement readElement() {
    final index = readByte();

    if (index == 0xff) {
      final type = readByte();

      if (type == 0x41) {
        return _readMatrixElement();
      } else if (type == 0x42) {
        return _readBlobElement();
      } else if (type == 0x43) {
        return _readUndefinedElement(5);
      } else if (type == 0x4e) {
        return _readNullElement();
      } else if (type == 0x50) {
        return _readOpeningElement();
      } else if (type == 0x52) {
        return _readReferenceElement();
      } else if (type == 0x56) {
        return _readValueElement();
      } else if (type == 0x70) {
        return _readClosingElement();
      } else {
        throw BinElementInvalidException();
      }
    }

    return _readCachedElement(index);
  }

  BinBlobElement _readBlobElement() {
    final size = readUint32(Endian.little);
    final bytes = readBytes(size);

    final element = BinBlobElement(
      size: size,
      bytes: bytes,
    );

    _elements.add(element);

    return element;
  }

  BinBlobElement _readCachedBlobElement(
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

  BinClosingElement _readCachedClosingElement(
    int index,
  ) {
    final element = _elements[index] as BinClosingElement;

    return element.copyWith();
  }

  BinElement _readCachedElement(
    int index,
  ) {
    final element = _elements[index] as BinElement;

    if (element is BinMatrixElement) {
      return _readCachedMatrixElement(index);
    } else if (element is BinBlobElement) {
      return _readCachedBlobElement(index);
    } else if (element is BinNullElement) {
      return _readCachedNullElement(index);
    } else if (element is BinOpeningElement) {
      return _readCachedOpeningElement(index);
    } else if (element is BinReferenceElement) {
      return _readCachedReferenceElement(index);
    } else if (element is BinValueElement) {
      return _readCachedValueElement(index);
    } else if (element is BinClosingElement) {
      return _readCachedClosingElement(index);
    } else {
      throw BinElementInvalidException(null, element);
    }
  }

  BinMatrixElement _readCachedMatrixElement(
    int index,
  ) {
    final element = _elements[index] as BinMatrixElement;

    final numElements = readByte();

    final elements = <Object>[];
    for (var i = 0; i < numElements; i++) {
      elements.add(_readValue(element.elementType));
    }

    return element.copyWith(
      numElements: numElements,
      elements: elements,
    );
  }

  BinNullElement _readCachedNullElement(
    int index,
  ) {
    final element = _elements[index] as BinNullElement;

    return element.copyWith();
  }

  BinOpeningElement _readCachedOpeningElement(
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

  BinReferenceElement _readCachedReferenceElement(
    int index,
  ) {
    final element = _elements[index] as BinReferenceElement;

    final value = readUint32(Endian.little);

    return element.copyWith(
      value: value,
    );
  }

  BinValueElement _readCachedValueElement(
    int index,
  ) {
    final element = _elements[index] as BinValueElement;

    final value = _readValue(element.type);

    return element.copyWith(
      value: value,
    );
  }

  BinClosingElement _readClosingElement() {
    final name = _readString();

    final element = BinClosingElement(
      name: name,
    );

    _elements.add(element);

    return element;
  }

  BinMatrixElement _readMatrixElement() {
    final name = _readString();
    final elementType = _readString();
    final numElements = readByte();

    final elements = <Object>[];
    for (var i = 0; i < numElements; i++) {
      elements.add(_readValue(elementType));
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

  BinNullElement _readNullElement() {
    final element = const BinNullElement();

    _elements.add(element);

    return element;
  }

  BinOpeningElement _readOpeningElement() {
    final name = _readString();
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

  BinReferenceElement _readReferenceElement() {
    final name = _readString();
    final value = readUint32(Endian.little);

    final element = BinReferenceElement(
      name: name,
      value: value,
    );

    _elements.add(element);

    return element;
  }

  String _readString() {
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

  BinUndefinedElement _readUndefinedElement(
    int length,
  ) {
    final bytes = readBytes(length);

    final element = BinUndefinedElement(
      bytes: bytes,
    );

    _elements.add(element);

    return element;
  }

  Object _readValue(
    String dataType,
  ) {
    switch (dataType) {
      case RailWorksDataTypes.bool:
        return readBool();
      case RailWorksDataTypes.cDeltaString:
        return _readString();
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

  BinValueElement _readValueElement() {
    final name = _readString();
    final type = _readString();
    final value = _readValue(type);

    final element = BinValueElement(
      name: name,
      type: type,
      value: value,
    );

    _elements.add(element);

    return element;
  }
}
