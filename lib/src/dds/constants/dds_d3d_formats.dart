import '../models/dds.dart';
import '../models/dds_header_dxt10.dart';

class DdsD3dFormats {
  /// The format is not known.
  static const unknown = 0x0;

  /// Indicates the presence of the [Dds.header10] extended header, and the [DdsHeaderDxt10.dxgiFormat] member of that structure indicates the true format.
  static const dx10 = 0x30315844;

  /// DXT1 compression texture format.
  static const dxt1 = 0x31545844;

  /// DXT2 compression texture format.
  static const dxt2 = 0x32545844;

  /// DXT3 compression texture format.
  static const dxt3 = 0x33545844;

  /// DXT4 compression texture format.
  static const dxt4 = 0x34545844;

  /// DXT5 compression texture format.
  static const dxt5 = 0x35545844;

  /// MultiElement texture (not compressed).
  static const multi2Argb8 = 0x3154454d;

  /// A 16-bit packed RGB format analogous to YUY2 (Y0U0, Y1V0, Y2U2, and so on). It requires a pixel pair in order to properly represent the color value. The first pixel in the pair contains 8 bits of green (in the high 8 bits) and 8 bits of red (in the low 8 bits). The second pixel contains 8 bits of green (in the high 8 bits) and 8 bits of blue (in the low 8 bits). Together, the two pixels share the red and blue components, while each has a unique green component (G0R0, G1B0, G2R2, and so on). The texture sampler does not normalize the colors when looking up into a pixel shader; they remain in the range of 0.0f to 255.0f. This is true for all programmable pixel shader models. For the fixed function pixel shader, the hardware should normalize to the 0.f to 1.f range and essentially treat it as the YUY2 texture. Hardware that exposes this format must have the PixelShader1xMaxValue member of D3DCAPS9 set to a value capable of handling that range.
  static const g8r8G8b8 = 0x42475247;

  /// A 16-bit packed RGB format analogous to UYVY (U0Y0, V0Y1, U2Y2, and so on). It requires a pixel pair in order to properly represent the color value. The first pixel in the pair contains 8 bits of green (in the low 8 bits) and 8 bits of red (in the high 8 bits). The second pixel contains 8 bits of green (in the low 8 bits) and 8 bits of blue (in the high 8 bits). Together, the two pixels share the red and blue components, while each has a unique green component (R0G0, B0G1, R2G2, and so on). The texture sampler does not normalize the colors when looking up into a pixel shader; they remain in the range of 0.0f to 255.0f. This is true for all programmable pixel shader models. For the fixed function pixel shader, the hardware should normalize to the 0.f to 1.f range and essentially treat it as the YUY2 texture. Hardware that exposes this format must have PixelShader1xMaxValue member of D3DCAPS9 set to a value capable of handling that range.
  static const r8g8B8g8 = 0x47424752;

  /// UYVY format (PC98 compliance).
  static const uyvy = 0x59565955;

  /// YUY2 format (PC98 compliance).
  static const yuy2 = 0x32595559;
}
