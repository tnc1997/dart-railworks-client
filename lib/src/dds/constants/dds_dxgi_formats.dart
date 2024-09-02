class DdsDxgiFormats {
  /// The format is not known.
  static const unknown = 0x0;

  /// A four-component, 128-bit typeless format that supports 32 bits per channel including alpha.
  static const r32g32b32a32Typeless = 0x1;

  /// A four-component, 128-bit floating-point format that supports 32 bits per channel including alpha.
  static const r32g32b32a32Float = 0x2;

  /// A four-component, 128-bit unsigned-integer format that supports 32 bits per channel including alpha.
  static const r32g32b32a32Uint = 0x3;

  /// A four-component, 128-bit signed-integer format that supports 32 bits per channel including alpha.
  static const r32g32b32a32Sint = 0x4;

  /// A three-component, 96-bit typeless format that supports 32 bits per color channel.
  static const r32g32b32Typeless = 0x5;

  /// A three-component, 96-bit floating-point format that supports 32 bits per color channel.
  static const r32g32b32Float = 0x6;

  /// A three-component, 96-bit unsigned-integer format that supports 32 bits per color channel.
  static const r32g32b32Uint = 0x7;

  /// A three-component, 96-bit signed-integer format that supports 32 bits per color channel.
  static const r32g32b32Sint = 0x8;

  /// A four-component, 64-bit typeless format that supports 16 bits per channel including alpha.
  static const r16g16b16a16Typeless = 0x9;

  /// A four-component, 64-bit floating-point format that supports 16 bits per channel including alpha.
  static const r16g16b16a16Float = 0xa;

  /// A four-component, 64-bit unsigned-normalized-integer format that supports 16 bits per channel including alpha.
  static const r16g16b16a16Unorm = 0xb;

  /// A four-component, 64-bit unsigned-integer format that supports 16 bits per channel including alpha.
  static const r16g16b16a16Uint = 0xc;

  /// A four-component, 64-bit signed-normalized-integer format that supports 16 bits per channel including alpha.
  static const r16g16b16a16Snorm = 0xd;

  /// A four-component, 64-bit signed-integer format that supports 16 bits per channel including alpha.
  static const r16g16b16a16Sint = 0xe;

  /// A two-component, 64-bit typeless format that supports 32 bits for the red channel and 32 bits for the green channel.
  static const r32g32Typeless = 0xf;

  /// A two-component, 64-bit floating-point format that supports 32 bits for the red channel and 32 bits for the green channel.
  static const r32g32Float = 0x10;

  /// A two-component, 64-bit unsigned-integer format that supports 32 bits for the red channel and 32 bits for the green channel.
  static const r32g32Uint = 0x11;

  /// A two-component, 64-bit signed-integer format that supports 32 bits for the red channel and 32 bits for the green channel.
  static const r32g32Sint = 0x12;

  /// A two-component, 64-bit typeless format that supports 32 bits for the red channel, 8 bits for the green channel, and 24 bits are unused.
  static const r32g8x24Typeless = 0x13;

  /// A 32-bit floating-point component, and two unsigned-integer components (with an additional 32 bits). This format supports 32-bit depth, 8-bit stencil, and 24 bits are unused.
  static const d32FloatS8x24Uint = 0x14;

  /// A 32-bit floating-point component, and two typeless components (with an additional 32 bits). This format supports 32-bit red channel, 8 bits are unused, and 24 bits are unused.
  static const r32FloatX8x24Typeless = 0x15;

  /// A 32-bit typeless component, and two unsigned-integer components (with an additional 32 bits). This format has 32 bits unused, 8 bits for green channel, and 24 bits are unused.
  static const x32TypelessG8x24Uint = 0x16;

  /// A four-component, 32-bit typeless format that supports 10 bits for each color and 2 bits for alpha.
  static const r10g10b10a2Typeless = 0x17;

  /// A four-component, 32-bit unsigned-normalized-integer format that supports 10 bits for each color and 2 bits for alpha.
  static const r10g10b10a2Unorm = 0x18;

  /// A four-component, 32-bit unsigned-integer format that supports 10 bits for each color and 2 bits for alpha.
  static const r10g10b10a2Uint = 0x19;

  /// Three partial-precision floating-point numbers encoded into a single 32-bit value (a variant of s10e5, which is sign bit, 10-bit mantissa, and 5-bit biased (15) exponent). There are no sign bits, and there is a 5-bit biased (15) exponent for each channel, 6-bit mantissa for R and G, and a 5-bit mantissa for B.
  static const r11g11b10Float = 0x1a;

  /// A four-component, 32-bit typeless format that supports 8 bits per channel including alpha.
  static const r8g8b8a8Typeless = 0x1b;

  /// A four-component, 32-bit unsigned-normalized-integer format that supports 8 bits per channel including alpha.
  static const r8g8b8a8Unorm = 0x1c;

  /// A four-component, 32-bit unsigned-normalized integer sRGB format that supports 8 bits per channel including alpha.
  static const r8g8b8a8UnormSrgb = 0x1d;

  /// A four-component, 32-bit unsigned-integer format that supports 8 bits per channel including alpha.
  static const r8g8b8a8Uint = 0x1e;

  /// A four-component, 32-bit signed-normalized-integer format that supports 8 bits per channel including alpha.
  static const r8g8b8a8Snorm = 0x1f;

  /// A four-component, 32-bit signed-integer format that supports 8 bits per channel including alpha.
  static const r8g8b8a8Sint = 0x20;

  /// A two-component, 32-bit typeless format that supports 16 bits for the red channel and 16 bits for the green channel.
  static const r16g16Typeless = 0x21;

  /// A two-component, 32-bit floating-point format that supports 16 bits for the red channel and 16 bits for the green channel.
  static const r16g16Float = 0x22;

  /// A two-component, 32-bit unsigned-normalized-integer format that supports 16 bits each for the green and red channels.
  static const r16g16Unorm = 0x23;

  /// A two-component, 32-bit unsigned-integer format that supports 16 bits for the red channel and 16 bits for the green channel.
  static const r16g16Uint = 0x24;

  /// A two-component, 32-bit signed-normalized-integer format that supports 16 bits for the red channel and 16 bits for the green channel.
  static const r16g16Snorm = 0x25;

  /// A two-component, 32-bit signed-integer format that supports 16 bits for the red channel and 16 bits for the green channel.
  static const r16g16Sint = 0x26;

  /// A single-component, 32-bit typeless format that supports 32 bits for the red channel.
  static const r32Typeless = 0x27;

  /// A single-component, 32-bit floating-point format that supports 32 bits for depth.
  static const d32Float = 0x28;

  /// A single-component, 32-bit floating-point format that supports 32 bits for the red channel.
  static const r32Float = 0x29;

  /// A single-component, 32-bit unsigned-integer format that supports 32 bits for the red channel.
  static const r32Uint = 0x2a;

  /// A single-component, 32-bit signed-integer format that supports 32 bits for the red channel.
  static const r32Sint = 0x2b;

  /// A two-component, 32-bit typeless format that supports 24 bits for the red channel and 8 bits for the green channel.
  static const r24g8Typeless = 0x2c;

  /// A 32-bit z-buffer format that supports 24 bits for depth and 8 bits for stencil.
  static const d24UnormS8Uint = 0x2d;

  /// A 32-bit format, that contains a 24 bit, single-component, unsigned-normalized integer, with an additional typeless 8 bits. This format has 24 bits red channel and 8 bits unused.
  static const r24UnormX8Typeless = 0x2e;

  /// A 32-bit format, that contains a 24 bit, single-component, typeless format, with an additional 8 bit unsigned integer component. This format has 24 bits unused and 8 bits green channel.
  static const x24TypelessG8Uint = 0x2f;

  /// A two-component, 16-bit typeless format that supports 8 bits for the red channel and 8 bits for the green channel.
  static const r8g8Typeless = 0x30;

  /// A two-component, 16-bit unsigned-normalized-integer format that supports 8 bits for the red channel and 8 bits for the green channel.
  static const r8g8Unorm = 0x31;

  /// A two-component, 16-bit unsigned-integer format that supports 8 bits for the red channel and 8 bits for the green channel.
  static const r8g8Uint = 0x32;

  /// A two-component, 16-bit signed-normalized-integer format that supports 8 bits for the red channel and 8 bits for the green channel.
  static const r8g8Snorm = 0x33;

  /// A two-component, 16-bit signed-integer format that supports 8 bits for the red channel and 8 bits for the green channel.
  static const r8g8Sint = 0x34;

  /// A single-component, 16-bit typeless format that supports 16 bits for the red channel.
  static const r16Typeless = 0x35;

  /// A single-component, 16-bit floating-point format that supports 16 bits for the red channel.
  static const r16Float = 0x36;

  /// A single-component, 16-bit unsigned-normalized-integer format that supports 16 bits for depth.
  static const d16Unorm = 0x37;

  /// A single-component, 16-bit unsigned-normalized-integer format that supports 16 bits for the red channel.
  static const r16Unorm = 0x38;

  /// A single-component, 16-bit unsigned-integer format that supports 16 bits for the red channel.
  static const r16Uint = 0x39;

  /// A single-component, 16-bit signed-normalized-integer format that supports 16 bits for the red channel.
  static const r16Snorm = 0x3a;

  /// A single-component, 16-bit signed-integer format that supports 16 bits for the red channel.
  static const r16Sint = 0x3b;

  /// A single-component, 8-bit typeless format that supports 8 bits for the red channel.
  static const r8Typeless = 0x3c;

  /// A single-component, 8-bit unsigned-normalized-integer format that supports 8 bits for the red channel.
  static const r8Unorm = 0x3d;

  /// A single-component, 8-bit unsigned-integer format that supports 8 bits for the red channel.
  static const r8Uint = 0x3e;

  /// A single-component, 8-bit signed-normalized-integer format that supports 8 bits for the red channel.
  static const r8Snorm = 0x3f;

  /// A single-component, 8-bit signed-integer format that supports 8 bits for the red channel.
  static const r8Sint = 0x40;

  /// A single-component, 8-bit unsigned-normalized-integer format for alpha only.
  static const a8Unorm = 0x41;

  /// A single-component, 1-bit unsigned-normalized integer format that supports 1 bit for the red channel.
  static const r1Unorm = 0x42;

  /// Three partial-precision floating-point numbers encoded into a single 32-bit value all sharing the same 5-bit exponent (variant of s10e5, which is sign bit, 10-bit mantissa, and 5-bit biased (15) exponent). There is no sign bit, and there is a shared 5-bit biased (15) exponent and a 9-bit mantissa for each channel.
  static const r9g9b9e5Sharedexp = 0x43;

  /// A four-component, 32-bit unsigned-normalized-integer format. This packed RGB format is analogous to the UYVY format. Each 32-bit block describes a pair of pixels: (R8, G8, B8) and (R8, G8, B8) where the R8/B8 values are repeated, and the G8 values are unique to each pixel.
  static const r8g8B8g8Unorm = 0x44;

  /// A four-component, 32-bit unsigned-normalized-integer format. This packed RGB format is analogous to the YUY2 format. Each 32-bit block describes a pair of pixels: (R8, G8, B8) and (R8, G8, B8) where the R8/B8 values are repeated, and the G8 values are unique to each pixel.
  static const g8r8G8b8Unorm = 0x45;

  /// Four-component typeless block-compression format.
  static const bc1Typeless = 0x46;

  /// Four-component block-compression format.
  static const bc1Unorm = 0x47;

  /// Four-component block-compression format for sRGB data.
  static const bc1UnormSrgb = 0x48;

  /// Four-component typeless block-compression format.
  static const bc2Typeless = 0x49;

  /// Four-component block-compression format.
  static const bc2Unorm = 0x4a;

  /// Four-component block-compression format for sRGB data.
  static const bc2UnormSrgb = 0x4b;

  /// Four-component typeless block-compression format.
  static const bc3Typeless = 0x4c;

  /// Four-component block-compression format.
  static const bc3Unorm = 0x4d;

  /// Four-component block-compression format for sRGB data.
  static const bc3UnormSrgb = 0x4e;

  /// One-component typeless block-compression format.
  static const bc4Typeless = 0x4f;

  /// One-component block-compression format.
  static const bc4Unorm = 0x50;

  /// One-component block-compression format.
  static const bc4Snorm = 0x51;

  /// Two-component typeless block-compression format.
  static const bc5Typeless = 0x52;

  /// Two-component block-compression format.
  static const bc5Unorm = 0x53;

  /// Two-component block-compression format.
  static const bc5Snorm = 0x54;

  /// A three-component, 16-bit unsigned-normalized-integer format that supports 5 bits for blue, 6 bits for green, and 5 bits for red.
  static const b5g6r5Unorm = 0x55;

  /// A four-component, 16-bit unsigned-normalized-integer format that supports 5 bits for each color channel and 1-bit alpha.
  static const b5g5r5a1Unorm = 0x56;

  /// A four-component, 32-bit unsigned-normalized-integer format that supports 8 bits for each color channel and 8-bit alpha.
  static const b8g8r8a8Unorm = 0x57;

  /// A four-component, 32-bit unsigned-normalized-integer format that supports 8 bits for each color channel and 8 bits unused.
  static const b8g8r8x8Unorm = 0x58;

  /// A four-component, 32-bit 2.8-biased fixed-point format that supports 10 bits for each color channel and 2-bit alpha.
  static const r10g10b10XrBiasA2Unorm = 0x59;

  /// A four-component, 32-bit typeless format that supports 8 bits for each channel including alpha.
  static const b8g8r8a8Typeless = 0x5a;

  /// A four-component, 32-bit unsigned-normalized standard RGB format that supports 8 bits for each channel including alpha.
  static const b8g8r8a8UnormSrgb = 0x5b;

  /// A four-component, 32-bit typeless format that supports 8 bits for each color channel, and 8 bits are unused.
  static const b8g8r8x8Typeless = 0x5c;

  /// A four-component, 32-bit unsigned-normalized standard RGB format that supports 8 bits for each color channel, and 8 bits are unused.
  static const b8g8r8x8UnormSrgb = 0x5d;

  /// A typeless block-compression format.
  static const bc6hTypeless = 0x5e;

  /// A block-compression format.
  static const bc6hUf16 = 0x5f;

  /// A block-compression format.
  static const bc6hSf16 = 0x60;

  /// A typeless block-compression format.
  static const bc7Typeless = 0x61;

  /// A block-compression format.
  static const bc7Unorm = 0x62;

  /// A block-compression format.
  static const bc7UnormSrgb = 0x63;

  /// Most common YUV 4:4:4 video resource format. Valid view formats for this video resource format are R8G8B8A8_UNORM and R8G8B8A8_UINT. For UAVs, an additional valid view format is R32_UINT. By using R32_UINT for UAVs, you can both read and write as opposed to just write for R8G8B8A8_UNORM and R8G8B8A8_UINT. Supported view types are SRV, RTV, and UAV. One view provides a straightforward mapping of the entire surface. The mapping to the view channel is V->R8, U->G8, Y->B8, and A->A8.
  static const ayuv = 0x64;

  /// 10-bit per channel packed YUV 4:4:4 video resource format. Valid view formats for this video resource format are R10G10B10A2_UNORM and R10G10B10A2_UINT. For UAVs, an additional valid view format is R32_UINT. By using R32_UINT for UAVs, you can both read and write as opposed to just write for R10G10B10A2_UNORM and R10G10B10A2_UINT. Supported view types are SRV and UAV. One view provides a straightforward mapping of the entire surface. The mapping to the view channel is U->R10, Y->G10, V->B10, and A->A2.
  static const y410 = 0x65;

  /// 16-bit per channel packed YUV 4:4:4 video resource format. Valid view formats for this video resource format are R16G16B16A16_UNORM and R16G16B16A16_UINT. Supported view types are SRV and UAV. One view provides a straightforward mapping of the entire surface. The mapping to the view channel is U->R16, Y->G16, V->B16, and A->A16.
  static const y416 = 0x66;

  /// Most common YUV 4:2:0 video resource format. Valid luminance data view formats for this video resource format are R8_UNORM and R8_UINT. Valid chrominance data view formats (width and height are each 1/2 of luminance view) for this video resource format are R8G8_UNORM and R8G8_UINT. Supported view types are SRV, RTV, and UAV. For luminance data view, the mapping to the view channel is Y->R8. For chrominance data view, the mapping to the view channel is U->R8 and V->G8. Width and height must be even. Direct3D 11 staging resources and initData parameters for this format use (rowPitch * (height + (height / 2))) bytes. The first (SysMemPitch * height) bytes are the Y plane, the remaining (SysMemPitch * (height / 2)) bytes are the UV plane. An app using the YUY 4:2:0 formats must map the luma (Y) plane separately from the chroma (UV) planes. Developers do this by calling ID3D12Device::CreateShaderResourceView twice for the same texture and passing in 1-channel and 2-channel formats. Passing in a 1-channel format compatible with the Y plane maps only the Y plane. Passing in a 2-channel format compatible with the UV planes (together) maps only the U and V planes as a single resource view.
  static const nv12 = 0x67;

  /// 10-bit per channel planar YUV 4:2:0 video resource format. Valid luminance data view formats for this video resource format are R16_UNORM and R16_UINT. The runtime does not enforce whether the lowest 6 bits are 0 (given that this video resource format is a 10-bit format that uses 16 bits). If required, application shader code would have to enforce this manually. From the runtime's point of view, P010 is no different than P016. Valid chrominance data view formats (width and height are each 1/2 of luminance view) for this video resource format are R16G16_UNORM and R16G16_UINT. For UAVs, an additional valid chrominance data view format is R32_UINT. By using R32_UINT for UAVs, you can both read and write as opposed to just write for R16G16_UNORM and R16G16_UINT. Supported view types are SRV, RTV, and UAV. For luminance data view, the mapping to the view channel is Y->R16. For chrominance data view, the mapping to the view channel is U->R16 and V->G16. Width and height must be even. Direct3D 11 staging resources and initData parameters for this format use (rowPitch * (height + (height / 2))) bytes. The first (SysMemPitch * height) bytes are the Y plane, the remaining (SysMemPitch * (height / 2)) bytes are the UV plane. An app using the YUY 4:2:0 formats must map the luma (Y) plane separately from the chroma (UV) planes. Developers do this by calling ID3D12Device::CreateShaderResourceView twice for the same texture and passing in 1-channel and 2-channel formats. Passing in a 1-channel format compatible with the Y plane maps only the Y plane. Passing in a 2-channel format compatible with the UV planes (together) maps only the U and V planes as a single resource view.
  static const p010 = 0x68;

  /// 16-bit per channel planar YUV 4:2:0 video resource format. Valid luminance data view formats for this video resource format are R16_UNORM and R16_UINT. Valid chrominance data view formats (width and height are each 1/2 of luminance view) for this video resource format are R16G16_UNORM and R16G16_UINT. For UAVs, an additional valid chrominance data view format is R32_UINT. By using R32_UINT for UAVs, you can both read and write as opposed to just write for R16G16_UNORM and R16G16_UINT. Supported view types are SRV, RTV, and UAV. For luminance data view, the mapping to the view channel is Y->R16. For chrominance data view, the mapping to the view channel is U->R16 and V->G16. Width and height must be even. Direct3D 11 staging resources and initData parameters for this format use (rowPitch * (height + (height / 2))) bytes. The first (SysMemPitch * height) bytes are the Y plane, the remaining (SysMemPitch * (height / 2)) bytes are the UV plane. An app using the YUY 4:2:0 formats must map the luma (Y) plane separately from the chroma (UV) planes. Developers do this by calling ID3D12Device::CreateShaderResourceView twice for the same texture and passing in 1-channel and 2-channel formats. Passing in a 1-channel format compatible with the Y plane maps only the Y plane. Passing in a 2-channel format compatible with the UV planes (together) maps only the U and V planes as a single resource view.
  static const p016 = 0x69;

  /// 8-bit per channel planar YUV 4:2:0 video resource format. This format is subsampled where each pixel has its own Y value, but each 2x2 pixel block shares a single U and V value. The runtime requires that the width and height of all resources that are created with this format are multiples of 2. The runtime also requires that the left, right, top, and bottom members of any RECT that are used for this format are multiples of 2. This format differs from NV12 in that the layout of the data within the resource is completely opaque to applications. Applications cannot use the CPU to map the resource and then access the data within the resource. You cannot use shaders with this format. Because of this behavior, legacy hardware that supports a non-NV12 4:2:0 layout (for example, YV12, and so on) can be used. Also, new hardware that has a 4:2:0 implementation better than NV12 can be used when the application does not need the data to be in a standard layout. Width and height must be even. Direct3D 11 staging resources and initData parameters for this format use (rowPitch * (height + (height / 2))) bytes. An app using the YUY 4:2:0 formats must map the luma (Y) plane separately from the chroma (UV) planes. Developers do this by calling ID3D12Device::CreateShaderResourceView twice for the same texture and passing in 1-channel and 2-channel formats. Passing in a 1-channel format compatible with the Y plane maps only the Y plane. Passing in a 2-channel format compatible with the UV planes (together) maps only the U and V planes as a single resource view.
  static const opaque420 = 0x6a;

  /// Most common YUV 4:2:2 video resource format. Valid view formats for this video resource format are R8G8B8A8_UNORM and R8G8B8A8_UINT. For UAVs, an additional valid view format is R32_UINT. By using R32_UINT for UAVs, you can both read and write as opposed to just write for R8G8B8A8_UNORM and R8G8B8A8_UINT. Supported view types are SRV and UAV. One view provides a straightforward mapping of the entire surface. The mapping to the view channel is Y0->R8, U0->G8, Y1->B8, and V0->A8. A unique valid view format for this video resource format is R8G8_B8G8_UNORM. With this view format, the width of the view appears to be twice what the R8G8B8A8_UNORM or R8G8B8A8_UINT view would be when hardware reconstructs RGBA automatically on read and before filtering. This Direct3D hardware behavior is legacy and is likely not useful any more. With this view format, the mapping to the view channel is Y0->R8, U0->G8[0], Y1->B8, and V0->G8[1].
  static const yuy2 = 0x6b;

  /// 10-bit per channel packed YUV 4:2:2 video resource format. Valid view formats for this video resource format are R16G16B16A16_UNORM and R16G16B16A16_UINT. The runtime does not enforce whether the lowest 6 bits are 0 (given that this video resource format is a 10-bit format that uses 16 bits). If required, application shader code would have to enforce this manually. From the runtime's point of view, Y210 is no different than Y216. Supported view types are SRV and UAV. One view provides a straightforward mapping of the entire surface. The mapping to the view channel is Y0->R16, U->G16, Y1->B16, and V->A16.
  static const y210 = 0x6c;

  /// 16-bit per channel packed YUV 4:2:2 video resource format. Valid view formats for this video resource format are R16G16B16A16_UNORM and R16G16B16A16_UINT. Supported view types are SRV and UAV. One view provides a straightforward mapping of the entire surface. The mapping to the view channel is Y0->R16, U->G16, Y1->B16, and V->A16.
  static const y216 = 0x6d;

  /// Most common planar YUV 4:1:1 video resource format. Valid luminance data view formats for this video resource format are R8_UNORM and R8_UINT. Valid chrominance data view formats (width and height are each 1/4 of luminance view) for this video resource format are R8G8_UNORM and R8G8_UINT. Supported view types are SRV, RTV, and UAV. For luminance data view, the mapping to the view channel is Y->R8. For chrominance data view, the mapping to the view channel is U->R8 and V->G8. Width must be a multiple of 4. Direct3D11 staging resources and initData parameters for this format use (rowPitch * height * 2) bytes. The first (SysMemPitch * height) bytes are the Y plane, the next ((SysMemPitch / 2) * height) bytes are the UV plane, and the remainder is padding.
  static const nv11 = 0x6e;

  /// 4-bit palletized YUV format that is commonly used for DVD subpicture.
  static const ai44 = 0x6f;

  /// 4-bit palletized YUV format that is commonly used for DVD subpicture.
  static const ia44 = 0x70;

  /// 8-bit palletized format that is used for palletized RGB data when the processor processes ISDB-T data and for palletized YUV data when the processor processes BluRay data.
  static const p8 = 0x71;

  /// 8-bit palletized format with 8 bits of alpha that is used for palletized YUV data when the processor processes BluRay data.
  static const a8p8 = 0x72;

  /// A four-component, 16-bit unsigned-normalized integer format that supports 4 bits for each channel including alpha.
  static const b4g4r4a4Unorm = 0x73;

  /// A video format; an 8-bit version of a hybrid planar 4:2:2 format.
  static const p208 = 0x82;

  /// An 8 bit YCbCrA 4:4 rendering format.
  static const v208 = 0x83;

  /// An 8 bit YCbCrA 4:4:4:4 rendering format.
  static const v408 = 0x84;
}
