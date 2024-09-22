import 'dart:convert';
import 'dart:typed_data';

import '../../common/constants/railworks_data_types.dart';
import '../../common/exceptions/railworks_data_type_invalid_exception.dart';
import '../../common/iterables/circular_buffer.dart';
import '../../common/readers/stream_byte_reader_base.dart';
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
import 'bin_stream_byte_reader.dart';

mixin BinStreamByteReaderBase on StreamByteReaderBase
    implements BinStreamByteReader {
  final _elements = CircularBuffer<BinElement>(0xff);
  final _strings = CircularBuffer<String>(0xffff);

  @override
  Future<BinElement> readElement() async {
    final index = await readByte();

    if (index == 0xff) {
      final type = await readByte();

      if (type == 0x41) {
        return await _readMatrixElement();
      } else if (type == 0x42) {
        return await _readBlobElement();
      } else if (type == 0x43) {
        return await _readUndefinedElement(5);
      } else if (type == 0x4e) {
        return await _readNullElement();
      } else if (type == 0x50) {
        return await _readOpeningElement();
      } else if (type == 0x52) {
        return await _readReferenceElement();
      } else if (type == 0x56) {
        return await _readValueElement();
      } else if (type == 0x70) {
        return await _readClosingElement();
      } else {
        throw BinElementInvalidException();
      }
    }

    return await _readCachedElement(index);
  }

  Future<BinBlobElement> _readBlobElement() async {
    final size = await readUint32(Endian.little);
    final bytes = await readBytes(size);

    final element = BinBlobElement(
      size: size,
      bytes: bytes,
    );

    _elements.add(element);

    return element;
  }

  Future<BinBlobElement> _readCachedBlobElement(
    int index,
  ) async {
    final element = _elements[index] as BinBlobElement;

    final size = await readUint32(Endian.little);
    final bytes = await readBytes(size);

    return element.copyWith(
      size: size,
      bytes: bytes,
    );
  }

  Future<BinClosingElement> _readCachedClosingElement(
    int index,
  ) async {
    final element = _elements[index] as BinClosingElement;

    return element.copyWith();
  }

  Future<BinElement> _readCachedElement(
    int index,
  ) async {
    final element = _elements[index] as BinElement;

    if (element is BinMatrixElement) {
      return await _readCachedMatrixElement(index);
    } else if (element is BinBlobElement) {
      return await _readCachedBlobElement(index);
    } else if (element is BinNullElement) {
      return await _readCachedNullElement(index);
    } else if (element is BinOpeningElement) {
      return await _readCachedOpeningElement(index);
    } else if (element is BinReferenceElement) {
      return await _readCachedReferenceElement(index);
    } else if (element is BinValueElement) {
      return await _readCachedValueElement(index);
    } else if (element is BinClosingElement) {
      return await _readCachedClosingElement(index);
    } else {
      throw BinElementInvalidException(null, element);
    }
  }

  Future<BinMatrixElement> _readCachedMatrixElement(
    int index,
  ) async {
    final element = _elements[index] as BinMatrixElement;

    final numElements = await readByte();

    final elements = <Object>[];
    for (var i = 0; i < numElements; i++) {
      elements.add(_readValue(element.elementType));
    }

    return element.copyWith(
      numElements: numElements,
      elements: elements,
    );
  }

  Future<BinNullElement> _readCachedNullElement(
    int index,
  ) async {
    final element = _elements[index] as BinNullElement;

    return element.copyWith();
  }

  Future<BinOpeningElement> _readCachedOpeningElement(
    int index,
  ) async {
    final element = _elements[index] as BinOpeningElement;

    final id = await readUint32(Endian.little);
    final numChildren = await readUint32(Endian.little);

    return element.copyWith(
      id: id,
      numChildren: numChildren,
    );
  }

  Future<BinReferenceElement> _readCachedReferenceElement(
    int index,
  ) async {
    final element = _elements[index] as BinReferenceElement;

    final value = await readUint32(Endian.little);

    return element.copyWith(
      value: value,
    );
  }

  Future<BinValueElement> _readCachedValueElement(
    int index,
  ) async {
    final element = _elements[index] as BinValueElement;

    final value = await _readValue(element.type);

    return element.copyWith(
      value: value,
    );
  }

  Future<BinClosingElement> _readClosingElement() async {
    final name = await _readString();

    final element = BinClosingElement(
      name: name,
    );

    _elements.add(element);

    return element;
  }

  Future<BinMatrixElement> _readMatrixElement() async {
    final name = await _readString();
    final elementType = await _readString();
    final numElements = await readByte();

    final elements = <Object>[];
    for (var i = 0; i < numElements; i++) {
      elements.add(await _readValue(elementType));
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

  Future<BinOpeningElement> _readOpeningElement() async {
    final name = await _readString();
    final id = await readUint32(Endian.little);
    final numChildren = await readUint32(Endian.little);

    final element = BinOpeningElement(
      name: name,
      id: id,
      numChildren: numChildren,
    );

    _elements.add(element);

    return element;
  }

  Future<BinReferenceElement> _readReferenceElement() async {
    final name = await _readString();
    final value = await readUint32(Endian.little);

    final element = BinReferenceElement(
      name: name,
      value: value,
    );

    _elements.add(element);

    return element;
  }

  Future<String> _readString() async {
    final index = await readUint16(Endian.little);

    if (index == 0xffff) {
      final length = await readUint32(Endian.little);
      final codeUnits = await readBytes(length);

      final string = utf8.decode(codeUnits).replaceAll('::', '-');

      _strings.add(string);

      return string;
    } else {
      return _strings[index];
    }
  }

  Future<BinUndefinedElement> _readUndefinedElement(
    int length,
  ) async {
    final bytes = await readBytes(length);

    final element = BinUndefinedElement(
      bytes: bytes,
    );

    _elements.add(element);

    return element;
  }

  Future<Object> _readValue(
    String dataType,
  ) async {
    switch (dataType) {
      case RailWorksDataTypes.bool:
        return await readBool();
      case RailWorksDataTypes.cDeltaString:
        return await _readString();
      case RailWorksDataTypes.sfloat32:
        return await readFloat32(Endian.little);
      case RailWorksDataTypes.sint8:
        return await readInt8();
      case RailWorksDataTypes.sint16:
        return await readInt16(Endian.little);
      case RailWorksDataTypes.sint32:
        return await readInt32(Endian.little);
      case RailWorksDataTypes.sint64:
        return await readInt64(Endian.little);
      case RailWorksDataTypes.suint8:
        return await readUint8();
      case RailWorksDataTypes.suint16:
        return await readUint16(Endian.little);
      case RailWorksDataTypes.suint32:
        return await readUint32(Endian.little);
      case RailWorksDataTypes.suint64:
        return await readUint64(Endian.little);
      default:
        throw RailWorksDataTypeInvalidException();
    }
  }

  Future<BinValueElement> _readValueElement() async {
    final name = await _readString();
    final type = await _readString();
    final value = await _readValue(type);

    final element = BinValueElement(
      name: name,
      type: type,
      value: value,
    );

    _elements.add(element);

    return element;
  }
}
