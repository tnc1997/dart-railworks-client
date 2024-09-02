class DdsAlphaModes {
  /// Alpha channel content is unknown. This is the value for legacy files, which typically is assumed to be 'straight' alpha.
  static const unknown = 0x0;

  /// Any alpha channel content is presumed to use straight alpha.
  static const straight = 0x1;

  /// Any alpha channel content is using premultiplied alpha. The only legacy file formats that indicate this information are 'DX2' and 'DX4'.
  static const premultiplied = 0x2;

  /// Any alpha channel content is all set to fully opaque.
  static const opaque = 0x3;

  /// Any alpha channel content is being used as a 4th channel and is not intended to represent transparency (straight or premultiplied).
  static const custom = 0x4;
}
