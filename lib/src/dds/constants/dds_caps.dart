class DdsCaps {
  /// Optional; must be used on any file that contains more than one surface (a mipmap, a cubic environment map, or mipmapped volume texture).
  static const complex = 0x8;

  /// Optional; should be used for a mipmap.
  static const mipMap = 0x400000;

  /// Required.
  static const texture = 0x1000;
}
