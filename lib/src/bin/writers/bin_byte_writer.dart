import 'dart:convert';
import 'dart:typed_data';

import '../../common/constants/railworks_data_types.dart';
import '../../common/exceptions/railworks_data_type_invalid_exception.dart';
import '../../common/iterables/circular_buffer.dart';
import '../../common/writers/byte_writer.dart';
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

class BinByteWriter extends ByteWriter {
  final _elements = CircularBuffer<BinElement>(0xff);
  final _strings = CircularBuffer<String>(0xffff);

  BinByteWriter(
    Sink<List<int>> sink,
  ) : super(sink);

  void writeBlobElement(
    BinBlobElement element,
  ) {
    writeUint32(element.size, Endian.little);
    writeBytes(element.bytes);

    _elements.add(element);
  }

  void writeClosingElement(
    BinClosingElement element,
  ) {
    writeString(element.name);

    _elements.add(element);
  }

  void writeElement(
    BinElement element,
  ) {
    writeByte(0xff);

    if (element is BinMatrixElement) {
      writeByte(0x41);
      writeMatrixElement(element);
    } else if (element is BinBlobElement) {
      writeByte(0x42);
      writeBlobElement(element);
    } else if (element is BinUndefinedElement) {
      writeByte(0x43);
      writeUndefinedElement(element);
    } else if (element is BinNullElement) {
      writeByte(0x4e);
      writeNullElement(element);
    } else if (element is BinOpeningElement) {
      writeByte(0x50);
      writeOpeningElement(element);
    } else if (element is BinReferenceElement) {
      writeByte(0x52);
      writeReferenceElement(element);
    } else if (element is BinValueElement) {
      writeByte(0x56);
      writeValueElement(element);
    } else if (element is BinClosingElement) {
      writeByte(0x70);
      writeClosingElement(element);
    } else {
      throw BinElementInvalidException(null, element);
    }
  }

  void writeMatrixElement(
    BinMatrixElement element,
  ) {
    writeString(element.name);
    writeString(element.elementType);
    writeByte(element.numElements);

    for (var i = 0; i < element.numElements; i++) {
      writeValue(element.elementType, element.elements[i]);
    }

    _elements.add(element);
  }

  void writeNullElement(
    BinNullElement element,
  ) {
    _elements.add(element);
  }

  void writeOpeningElement(
    BinOpeningElement element,
  ) {
    writeString(element.name);
    writeUint32(element.id, Endian.little);
    writeUint32(element.numChildren, Endian.little);

    _elements.add(element);
  }

  void writeReferenceElement(
    BinReferenceElement element,
  ) {
    writeString(element.name);
    writeUint32(element.value, Endian.little);

    _elements.add(element);
  }

  void writeString(
    String value,
  ) {
    final index = _strings.indexOf(value);

    if (index == -1) {
      writeUint16(0xffff, Endian.little);

      final codeUnits = utf8.encode(value.replaceAll('-', '::'));

      writeUint32(codeUnits.length, Endian.little);
      writeBytes(codeUnits);

      _strings.add(value);
    } else {
      writeUint16(index, Endian.little);
    }
  }

  void writeUndefinedElement(
    BinUndefinedElement element,
  ) {
    writeBytes(element.bytes);

    _elements.add(element);
  }

  void writeValue(
    String dataType,
    Object value,
  ) {
    switch (dataType) {
      case RailWorksDataTypes.bool:
        return writeBool(value as bool);
      case RailWorksDataTypes.cDeltaString:
        return writeString(value as String);
      case RailWorksDataTypes.sfloat32:
        return writeFloat32(value as double, Endian.little);
      case RailWorksDataTypes.sint8:
        return writeInt8(value as int);
      case RailWorksDataTypes.sint16:
        return writeInt16(value as int, Endian.little);
      case RailWorksDataTypes.sint32:
        return writeInt32(value as int, Endian.little);
      case RailWorksDataTypes.sint64:
        return writeInt64(value as int, Endian.little);
      case RailWorksDataTypes.suint8:
        return writeUint8(value as int);
      case RailWorksDataTypes.suint16:
        return writeUint16(value as int, Endian.little);
      case RailWorksDataTypes.suint32:
        return writeUint32(value as int, Endian.little);
      case RailWorksDataTypes.suint64:
        return writeUint64(value as int, Endian.little);
      default:
        throw RailWorksDataTypeInvalidException();
    }
  }

  void writeValueElement(
    BinValueElement element,
  ) {
    writeString(element.name);
    writeString(element.type);
    writeValue(element.type, element.value);

    _elements.add(element);
  }
}
