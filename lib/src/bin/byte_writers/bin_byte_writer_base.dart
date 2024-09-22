import 'dart:convert';
import 'dart:typed_data';

import '../../common/byte_writers/railworks_byte_writer_base.dart';
import '../../common/constants/railworks_data_types.dart';
import '../../common/exceptions/railworks_data_type_invalid_exception.dart';
import '../../common/iterables/railworks_circular_buffer.dart';
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
import 'bin_byte_writer.dart';

mixin BinByteWriterBase on RailWorksByteWriterBase implements BinByteWriter {
  final _elements = RailWorksCircularBuffer<BinElement>(0xff);
  final _strings = RailWorksCircularBuffer<String>(0xffff);

  @override
  void writeElement(
    BinElement element,
  ) {
    writeByte(0xff);

    if (element is BinMatrixElement) {
      writeByte(0x41);
      _writeMatrixElement(element);
    } else if (element is BinBlobElement) {
      writeByte(0x42);
      _writeBlobElement(element);
    } else if (element is BinUndefinedElement) {
      writeByte(0x43);
      _writeUndefinedElement(element);
    } else if (element is BinNullElement) {
      writeByte(0x4e);
      _writeNullElement(element);
    } else if (element is BinOpeningElement) {
      writeByte(0x50);
      _writeOpeningElement(element);
    } else if (element is BinReferenceElement) {
      writeByte(0x52);
      _writeReferenceElement(element);
    } else if (element is BinValueElement) {
      writeByte(0x56);
      _writeValueElement(element);
    } else if (element is BinClosingElement) {
      writeByte(0x70);
      _writeClosingElement(element);
    } else {
      throw BinElementInvalidException(null, element);
    }
  }

  void _writeBlobElement(
    BinBlobElement element,
  ) {
    writeUint32(element.size, Endian.little);
    writeBytes(element.bytes);

    _elements.add(element);
  }

  void _writeClosingElement(
    BinClosingElement element,
  ) {
    _writeString(element.name);

    _elements.add(element);
  }

  void _writeMatrixElement(
    BinMatrixElement element,
  ) {
    _writeString(element.name);
    _writeString(element.elementType);
    writeByte(element.numElements);

    for (var i = 0; i < element.numElements; i++) {
      _writeValue(element.elementType, element.elements[i]);
    }

    _elements.add(element);
  }

  void _writeNullElement(
    BinNullElement element,
  ) {
    _elements.add(element);
  }

  void _writeOpeningElement(
    BinOpeningElement element,
  ) {
    _writeString(element.name);
    writeUint32(element.id, Endian.little);
    writeUint32(element.numChildren, Endian.little);

    _elements.add(element);
  }

  void _writeReferenceElement(
    BinReferenceElement element,
  ) {
    _writeString(element.name);
    writeUint32(element.value, Endian.little);

    _elements.add(element);
  }

  void _writeString(
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

  void _writeUndefinedElement(
    BinUndefinedElement element,
  ) {
    writeBytes(element.bytes);

    _elements.add(element);
  }

  void _writeValue(
    String dataType,
    Object value,
  ) {
    switch (dataType) {
      case RailWorksDataTypes.bool:
        return writeBool(value as bool);
      case RailWorksDataTypes.cDeltaString:
        return _writeString(value as String);
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

  void _writeValueElement(
    BinValueElement element,
  ) {
    _writeString(element.name);
    _writeString(element.type);
    _writeValue(element.type, element.value);

    _elements.add(element);
  }
}
