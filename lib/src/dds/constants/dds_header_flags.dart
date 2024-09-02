class DdsHeaderFlags {
  /// Required in every .dds file.
  static const caps = 0x1;

  /// Required in every .dds file.
  static const height = 0x2;

  /// Required in every .dds file.
  static const width = 0x4;

  /// Required when pitch is provided for an uncompressed texture.
  static const pitch = 0x8;

  /// Required in every .dds file.
  static const pixelFormat = 0x1000;

  /// Required in a mipmapped texture.
  static const mipMapCount = 0x20000;

  /// Required when pitch is provided for a compressed texture.
  static const linearSize = 0x80000;

  /// Required in a depth texture.
  static const depth = 0x800000;
}
