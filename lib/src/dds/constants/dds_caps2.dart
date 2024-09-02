class DdsCaps2 {
  /// Required for a cube map.
  static const cubeMap = 0x200;

  /// Required when these surfaces are stored in a cube map.
  static const cubeMapPositiveX = 0x400;

  /// Required when these surfaces are stored in a cube map.
  static const cubeMapNegativeX = 0x800;

  /// Required when these surfaces are stored in a cube map.
  static const cubeMapPositiveY = 0x1000;

  /// Required when these surfaces are stored in a cube map.
  static const cubeMapNegativeY = 0x2000;

  /// Required when these surfaces are stored in a cube map.
  static const cubeMapPositiveZ = 0x4000;

  /// Required when these surfaces are stored in a cube map.
  static const cubeMapNegativeZ = 0x8000;

  /// Required for a volume texture.
  static const volume = 0x200000;
}
