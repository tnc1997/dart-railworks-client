import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:convert/convert.dart';
import 'package:xml/xml_events.dart';

class BinToXml {
  static const _prelude = [0x53, 0x45, 0x52, 0x5A, 0x00, 0x00, 0x01, 0x00];

  final StreamIterator<int> _iterator;
  var _line = 0;
  final _savedNameList = <String>[];
  final _savedTokenList = List<Node?>.filled(0xFF, null);
  var _savedTokenListIndex = 0;
  Node? _lastNode = null;

  BinToXml(
    Stream<List<int>> stream,
  ) : _iterator = StreamIterator(
          stream.expand(
            (bytes) {
              return bytes;
            },
          ),
        );

  Stream<List<XmlEvent>> run() async* {
    await _iterator.moveNext();

    await _validatePrelude();

    while (true) {
      final int current;

      try {
        current = _iterator.current;
      } catch (e) {
        break;
      }

      if (current == 0xFF) {
        await _iterator.moveNext();

        switch (_iterator.current) {
          case 0x41:
            await _iterator.moveNext();

            final node = await _processFF41Node();

            if (_lastNode != null) {
              yield _getXmlEvents(_lastNode!);
            }

            _lastNode = node;
            _savedTokenList[_savedTokenListIndex] = node;

            break;
          case 0x42:
            await _iterator.moveNext();

            final node = await _processFF42Node();

            if (_lastNode != null) {
              yield _getXmlEvents(_lastNode!);
            }

            _lastNode = node;
            _savedTokenList[_savedTokenListIndex] = node;

            break;
          case 0x43:
            await _iterator.moveNext();

            await _iterator.readBytes(5);

            yield [
              XmlDeclarationEvent(
                [
                  XmlEventAttribute(
                    'version',
                    '1.0',
                    XmlAttributeType.DOUBLE_QUOTE,
                  ),
                  XmlEventAttribute(
                    'encoding',
                    'utf-8',
                    XmlAttributeType.DOUBLE_QUOTE,
                  ),
                ],
              ),
            ];

            break;
          case 0x4E:
            await _iterator.moveNext();

            final node = FF4ENode();

            if (_lastNode != null) {
              yield _getXmlEvents(_lastNode!);
            }

            _lastNode = node;
            _savedTokenList[_savedTokenListIndex] = node;

            break;
          case 0x50:
            await _iterator.moveNext();

            final node = await _processFF50Node();

            if (_lastNode != null) {
              yield _getXmlEvents(_lastNode!);
            }

            _lastNode = node;
            _savedTokenList[_savedTokenListIndex] = node;

            break;
          case 0x52:
            await _iterator.moveNext();

            final node = await _processFF52Node();

            if (_lastNode != null) {
              yield _getXmlEvents(_lastNode!);
            }

            _lastNode = node;
            _savedTokenList[_savedTokenListIndex] = node;

            break;
          case 0x56:
            await _iterator.moveNext();

            final node = await _processFF56Node();

            if (_lastNode != null) {
              yield _getXmlEvents(_lastNode!);
            }

            _lastNode = node;
            _savedTokenList[_savedTokenListIndex] = node;

            break;
          case 0x70:
            await _iterator.moveNext();

            final node = await _processFF70Node();

            if (_lastNode != null) {
              yield _getXmlEvents(_lastNode!);
            }

            _lastNode = node;
            _savedTokenList[_savedTokenListIndex] = node;

            break;
          default:
            throw Exception('Invalid node type');
        }

        _savedTokenListIndex = (_savedTokenListIndex + 1) % 0xFF;
      } else {
        final node = await _processSavedLine();

        if (_lastNode != null) {
          yield _getXmlEvents(_lastNode!);
        }

        _lastNode = node;
      }

      _line++;
    }

    if (_lastNode != null) {
      yield _getXmlEvents(_lastNode!);
    }
  }

  static int _getUtf8CharacterSize(
    int byte,
  ) {
    if (byte & 0x80 == 0x00) {
      return 1;
    } else if (byte & 0xE0 == 0xC0) {
      return 2;
    } else if (byte & 0xF0 == 0xE0) {
      return 3;
    } else if (byte & 0xF8 == 0xF0) {
      return 4;
    } else {
      throw Exception('Invalid UTF-8 character');
    }
  }

  static List<XmlEvent> _getXmlEvents(
    Node node,
  ) {
    if (node is FF41Node) {
      return [
        XmlStartElementEvent(
          node.name,
          <XmlEventAttribute>[
            XmlEventAttribute(
              'd:numElements',
              node.numElements.toString(),
              XmlAttributeType.DOUBLE_QUOTE,
            ),
            XmlEventAttribute(
              'd:elementType',
              node.elementType,
              XmlAttributeType.DOUBLE_QUOTE,
            ),
            if (node.elementType == DataTypes.sfloat32)
              XmlEventAttribute(
                'd:precision',
                'string',
                XmlAttributeType.DOUBLE_QUOTE,
              ),
          ],
          false,
        ),
        if (node.elementType == DataTypes.sfloat32)
          XmlTextEvent(
            node.values.cast<num>().map(
              (value) {
                return value.toStringAsFixed(7);
              },
            ).join(' '),
          )
        else
          XmlTextEvent(
            node.values.map(
              (value) {
                return value.toString();
              },
            ).join(' '),
          ),
        XmlEndElementEvent(
          node.name,
        ),
      ];
    } else if (node is FF42Node) {
      return [
        XmlStartElementEvent(
          'd:blob',
          [
            XmlEventAttribute(
              'd:size',
              node.size.toString(),
              XmlAttributeType.DOUBLE_QUOTE,
            ),
          ],
          false,
        ),
        XmlTextEvent(
          hex.encode(node.data).slices(16).slices(4).map(
            (values) {
              return values.join(' ');
            },
          ).join('\n'),
        ),
        XmlEndElementEvent(
          'd:blob',
        ),
      ];
    } else if (node is FF4ENode) {
      return [
        XmlStartElementEvent(
          'd:nil',
          [],
          true,
        ),
      ];
    } else if (node is FF50Node) {
      return [
        XmlStartElementEvent(
          node.name,
          [
            if (node.id != 0)
              XmlEventAttribute(
                'd:id',
                node.id.toString(),
                XmlAttributeType.DOUBLE_QUOTE,
              ),
          ],
          false,
        ),
      ];
    } else if (node is FF52Node) {
      return [
        XmlStartElementEvent(
          node.name,
          [
            XmlEventAttribute(
              'd:type',
              'ref',
              XmlAttributeType.DOUBLE_QUOTE,
            ),
          ],
          false,
        ),
        XmlTextEvent(
          node.value.toString(),
        ),
        XmlEndElementEvent(
          node.name,
        ),
      ];
    } else if (node is FF56Node) {
      return [
        XmlStartElementEvent(
          node.name,
          [
            XmlEventAttribute(
              'd:type',
              node.type,
              XmlAttributeType.DOUBLE_QUOTE,
            ),
            if (node.type == DataTypes.sfloat32)
              XmlEventAttribute(
                'd:alt_encoding',
                hex.encode(
                  (ByteData(8)..setFloat64(0, node.value, Endian.little))
                      .buffer
                      .asUint8List(),
                ),
                XmlAttributeType.DOUBLE_QUOTE,
              ),
            if (node.type == DataTypes.sfloat32)
              XmlEventAttribute(
                'd:precision',
                'string',
                XmlAttributeType.DOUBLE_QUOTE,
              ),
          ],
          false,
        ),
        if (node.type == DataTypes.bool)
          XmlTextEvent(
            node.value == true ? '1' : '0',
          )
        else if (node.type == DataTypes.sfloat32)
          XmlTextEvent(
            node.value.toStringAsPrecision(6),
          )
        else
          XmlTextEvent(
            node.value.toString(),
          ),
        XmlEndElementEvent(
          node.name,
        ),
      ];
    } else if (node is FF70Node) {
      return [
        XmlEndElementEvent(
          node.name,
        ),
      ];
    } else {
      throw Exception('Invalid node type');
    }
  }

  Future<String> _identifier(
    StringContext context,
  ) async {
    final first = _iterator.current;
    await _iterator.moveNext();
    final second = _iterator.current;
    await _iterator.moveNext();

    if (first == 0xFF && second == 0xFF) {
      final stringLength = await _iterator.readUint32(Endian.little);

      final codeUnits = <int>[];
      for (var i = 0; i < stringLength; i++) {
        final characterSize = _getUtf8CharacterSize(_iterator.current);
        final bytes = await _iterator.readBytes(characterSize);

        if (context == StringContext.name &&
            codeUnits.length > 0 &&
            characterSize == 1 &&
            bytes[0] == 0x3A &&
            codeUnits.last == 0x3A) {
          codeUnits[codeUnits.length - 1] = 0x2D;
        } else {
          codeUnits.addAll(bytes);
        }
      }

      final name = utf8.decode(codeUnits);

      _savedNameList.add(name);

      return context == StringContext.name && codeUnits.length == 0
          ? 'e'
          : name;
    } else {
      final stringIndex = (Uint8List(2)
            ..[0] = first
            ..[1] = second)
          .buffer
          .asByteData()
          .getUint16(0, Endian.little);

      final savedName = _savedNameList[stringIndex];

      return context == StringContext.name && savedName.length == 0
          ? 'e'
          : savedName;
    }
  }

  Future<FF41Node> _processFF41Node() async {
    final name = await _identifier(StringContext.name);
    final elementType = await _identifier(StringContext.type);
    final numElements = _iterator.current;

    await _iterator.moveNext();

    final values = <dynamic>[];
    for (var i = 0; i < numElements; i++) {
      values.add(await _processValue(elementType));
    }

    return FF41Node(
      name: name,
      elementType: elementType,
      numElements: numElements,
      values: values,
    );
  }

  Future<FF42Node> _processFF42Node() async {
    final size = await _iterator.readUint32(Endian.little);
    final data = await _iterator.readBytes(size);

    return FF42Node(
      size: size,
      data: data,
    );
  }

  Future<FF50Node> _processFF50Node() async {
    final name = await _identifier(StringContext.name);
    final id = await _iterator.readUint32(Endian.little);
    final children = await _iterator.readUint32(Endian.little);

    return FF50Node(
      name: name,
      id: id,
      children: children,
    );
  }

  Future<FF52Node> _processFF52Node() async {
    final name = await _identifier(StringContext.name);
    final value = await _iterator.readUint32(Endian.little);

    return FF52Node(
      name: name,
      value: value,
    );
  }

  Future<FF56Node> _processFF56Node() async {
    final name = await _identifier(StringContext.name);
    final type = await _identifier(StringContext.type);
    final value = await _processValue(type);

    return FF56Node(
      name: name,
      type: type,
      value: value,
    );
  }

  Future<FF70Node> _processFF70Node() async {
    final name = await _identifier(StringContext.name);

    return FF70Node(
      name: name,
    );
  }

  Future<Node> _processSavedLine() async {
    if (_iterator.current > _savedTokenList.length) {
      throw Exception('Invalid saved token list counter');
    }

    final lineNumber = _iterator.current;
    final savedLine = _savedTokenList[lineNumber];

    await _iterator.moveNext();

    if (savedLine is FF41Node) {
      final numElements = _iterator.current;

      await _iterator.moveNext();

      final values = <dynamic>[];
      for (var i = 0; i < savedLine.numElements; i++) {
        values.add(await _processValue(savedLine.elementType));
      }

      return FF41Node(
        name: savedLine.name,
        numElements: numElements,
        elementType: savedLine.elementType,
        values: values,
      );
    } else if (savedLine is FF42Node) {
      final size = await _iterator.readUint32(Endian.little);
      final data = await _iterator.readBytes(size);

      return FF42Node(
        size: size,
        data: data,
      );
    } else if (savedLine is FF4ENode) {
      return FF4ENode();
    } else if (savedLine is FF50Node) {
      final id = await _iterator.readUint32(Endian.little);
      final children = await _iterator.readUint32(Endian.little);

      if (children > 100) {
        throw Exception('Invalid number of children');
      }

      return FF50Node(
        name: savedLine.name,
        id: id,
        children: children,
      );
    } else if (savedLine is FF52Node) {
      final value = await _iterator.readUint32(Endian.little);

      return FF52Node(
        name: savedLine.name,
        value: value,
      );
    } else if (savedLine is FF56Node) {
      final value = await _processValue(savedLine.type);

      return FF56Node(
        name: savedLine.name,
        type: savedLine.type,
        value: value,
      );
    } else if (savedLine is FF70Node) {
      return FF70Node(
        name: savedLine.name,
      );
    } else {
      throw Exception('Invalid node type');
    }
  }

  Future<dynamic> _processValue(
    String type,
  ) async {
    switch (type) {
      case DataTypes.bool:
        return await _iterator.readBool();
      case DataTypes.string:
        return await _identifier(StringContext.value);
      case DataTypes.sfloat32:
        return await _iterator.readFloat32(Endian.little);
      case DataTypes.sint8:
        return await _iterator.readInt8();
      case DataTypes.sint16:
        return await _iterator.readInt16(Endian.little);
      case DataTypes.sint32:
        return await _iterator.readInt32(Endian.little);
      case DataTypes.sint64:
        return await _iterator.readInt64(Endian.little);
      case DataTypes.suint8:
        return await _iterator.readUint8();
      case DataTypes.suint16:
        return await _iterator.readUint16(Endian.little);
      case DataTypes.suint32:
        return await _iterator.readUint32(Endian.little);
      case DataTypes.suint64:
        return await _iterator.readUint64(Endian.little);
      default:
        throw Exception('Invalid data type');
    }
  }

  Future<void> _validatePrelude() async {
    for (final byte in _prelude) {
      if (_iterator.current != byte) {
        throw Exception('Invalid prelude');
      }

      await _iterator.moveNext();
    }
  }
}

class DataTypes {
  static const bool = 'bool';

  static const string = 'cDeltaString';

  /// Swapped IEEE 32-bit floating point.
  static const sfloat32 = 'sFloat32';

  /// Swapped IEEE 8-bit signed integer.
  static const sint8 = 'sInt8';

  /// Swapped IEEE 16-bit signed integer.
  static const sint16 = 'sInt16';

  /// Swapped IEEE 32-bit signed integer.
  static const sint32 = 'sInt32';

  /// Swapped IEEE 64-bit signed integer.
  static const sint64 = 'sInt64';

  /// Swapped IEEE 8-bit unsigned integer.
  static const suint8 = 'sUInt8';

  /// Swapped IEEE 16-bit unsigned integer.
  static const suint16 = 'sUInt16';

  /// Swapped IEEE 32-bit unsigned integer.
  static const suint32 = 'sUInt32';

  /// Swapped IEEE 64-bit unsigned integer.
  static const suint64 = 'sUInt64';
}

class FF41Node extends Node {
  final String name;
  final String elementType;
  final int numElements;
  final List<dynamic> values;

  const FF41Node({
    required this.name,
    required this.elementType,
    required this.numElements,
    required this.values,
  });

  FF41Node copyWith({
    String? name,
    String? elementType,
    int? numElements,
    List<dynamic>? values,
  }) {
    return FF41Node(
      name: name ?? this.name,
      elementType: elementType ?? this.elementType,
      numElements: numElements ?? this.numElements,
      values: values ?? this.values,
    );
  }

  @override
  String toString() {
    switch (elementType) {
      case DataTypes.sfloat32:
        return '<$name d:numElements="$numElements" d:elementType="$elementType" d:precision="string">${values.map((value) => (value as num).toStringAsFixed(7)).join(' ')}</$name>';
      default:
        return '<$name d:numElements="$numElements" d:elementType="$elementType">${values.map((value) => value.toString()).join(' ')}</$name>';
    }
  }
}

class FF42Node extends Node {
  final int size;
  final List<int> data;

  const FF42Node({
    required this.size,
    required this.data,
  });

  FF42Node copyWith({
    int? size,
    List<int>? data,
  }) {
    return FF42Node(
      size: size ?? this.size,
      data: data ?? this.data,
    );
  }

  @override
  String toString() {
    return '<d:blob d:size="$size">${hex.encode(data).slices(16).slices(4).map((values) => values.join(' ')).join('\n')}</d:blob>';
  }
}

class FF4ENode extends Node {
  const FF4ENode();

  @override
  String toString() {
    return '<d:nil/>';
  }
}

class FF50Node extends Node {
  final String name;
  final int id;
  final int children;

  const FF50Node({
    required this.name,
    required this.id,
    required this.children,
  });

  FF50Node copyWith({
    String? name,
    int? id,
    int? children,
  }) {
    return FF50Node(
      name: name ?? this.name,
      id: id ?? this.id,
      children: children ?? this.children,
    );
  }

  @override
  String toString() {
    if (id != 0) {
      return '<$name d:id="$id">';
    } else {
      return '<$name>';
    }
  }
}

class FF52Node extends Node {
  final String name;
  final int value;

  const FF52Node({
    required this.name,
    required this.value,
  });

  FF52Node copyWith({
    String? name,
    int? value,
  }) {
    return FF52Node(
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  @override
  String toString() {
    return '<$name d:type="ref">${value.toString()}</$name>';
  }
}

class FF56Node extends Node {
  final String name;
  final String type;
  final dynamic value;

  const FF56Node({
    required this.name,
    required this.type,
    required this.value,
  });

  FF56Node copyWith({
    String? name,
    String? type,
    dynamic value,
  }) {
    return FF56Node(
      name: name ?? this.name,
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }

  @override
  String toString() {
    switch (type) {
      case DataTypes.bool:
        return '<$name d:type="$type">${value == true ? '1' : '0'}</$name>';
      case DataTypes.sfloat32:
        return '<$name d:type="$type" d:alt_encoding="${hex.encode((ByteData(8)..setFloat64(0, value, Endian.little)).buffer.asUint8List())}" d:precision="string">${(value as num).toStringAsPrecision(6)}</$name>';
      default:
        return '<$name d:type="$type">${value.toString()}</$name>';
    }
  }
}

class FF70Node extends Node {
  final String name;

  const FF70Node({
    required this.name,
  });

  FF70Node copyWith({
    String? name,
  }) {
    return FF70Node(
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return '</$name>';
  }
}

abstract class Node {
  const Node();
}

enum StringContext {
  name,
  type,
  value,
}

class TextureFormats {
  /// DXGI_FORMAT_BC1_UNORM
  static const dxt1 = 'HC_IMAGE_FORMAT_COMPRESSED';

  /// DXGI_FORMAT_BC2_UNORM
  static const dxt3 = 'HC_IMAGE_FORMAT_COMPRESSED_EXPL_ALPHA';

  /// DXGI_FORMAT_BC3_UNORM
  static const dxt5 = 'HC_IMAGE_FORMAT_COMPRESSED_INTERP_ALPHA';

  /// DXGI_FORMAT_R8G8B8A8_UNORM
  static const rgb = 'HC_IMAGE_FORMAT_COL888';

  /// DXGI_FORMAT_R8G8B8A8_UNORM
  static const rgba = 'HC_IMAGE_FORMAT_COLA8888';
}

extension on StreamIterator<int> {
  Future<bool> readBool() async {
    final result = current == 1;

    await moveNext();

    return result;
  }

  Future<Uint8List> readBytes(
    int size,
  ) async {
    final bytes = Uint8List(size);

    for (var i = 0; i < size; i++) {
      bytes[i] = current;

      if (!await moveNext()) {
        break;
      }
    }

    return bytes;
  }

  Future<double> readFloat32([
    Endian endian = Endian.big,
  ]) async {
    final bytes = await readBytes(4);

    return bytes.buffer.asByteData().getFloat32(0, endian);
  }

  Future<int> readInt8() async {
    final bytes = await readBytes(1);

    return bytes.buffer.asByteData().getInt8(0);
  }

  Future<int> readInt16([
    Endian endian = Endian.big,
  ]) async {
    final bytes = await readBytes(2);

    return bytes.buffer.asByteData().getInt16(0, endian);
  }

  Future<int> readInt32([
    Endian endian = Endian.big,
  ]) async {
    final bytes = await readBytes(4);

    return bytes.buffer.asByteData().getInt32(0, endian);
  }

  Future<int> readInt64([
    Endian endian = Endian.big,
  ]) async {
    final bytes = await readBytes(8);

    return bytes.buffer.asByteData().getInt64(0, endian);
  }

  Future<int> readUint8() async {
    final bytes = await readBytes(1);

    return bytes.buffer.asByteData().getUint8(0);
  }

  Future<int> readUint16([
    Endian endian = Endian.big,
  ]) async {
    final bytes = await readBytes(2);

    return bytes.buffer.asByteData().getUint16(0, endian);
  }

  Future<int> readUint32([
    Endian endian = Endian.big,
  ]) async {
    final bytes = await readBytes(4);

    return bytes.buffer.asByteData().getUint32(0, endian);
  }

  Future<int> readUint64([
    Endian endian = Endian.big,
  ]) async {
    final bytes = await readBytes(8);

    return bytes.buffer.asByteData().getUint64(0, endian);
  }
}

extension on String {
  Iterable<String> slices(
    int length,
  ) sync* {
    for (final charCodes in codeUnits.slices(length)) {
      yield String.fromCharCodes(charCodes);
    }
  }
}
