import '../constants/dds_alpha_modes.dart';
import '../constants/dds_dxgi_formats.dart';
import '../constants/dds_resource_dimensions.dart';

class DdsHeaderDxt10 {
  /// The surface pixel format (see [DdsDxgiFormats]).
  final int dxgiFormat;

  /// Identifies the type of resource (see [DdsResourceDimensions]).
  final int resourceDimension;

  /// Identifies other, less common options for resources.
  final int miscFlag;

  /// The number of elements in the array. For a 2D texture that is also a cube-map texture, this number represents the number of cubes. This number is the same as the number in the NumCubes member of D3D10_TEXCUBE_ARRAY_SRV1 or D3D11_TEXCUBE_ARRAY_SRV. In this case, the .dds file contains arraySize*6 2D textures. For more information about this case, see the [miscFlag] description. For a 3D texture, you must set this number to 1.
  final int arraySize;

  /// Contains additional metadata. The lower 3 bits indicate the alpha mode of the associated resource. The upper 29 bits are reserved and are typically 0.
  final int miscFlags2;

  const DdsHeaderDxt10({
    this.dxgiFormat = DdsDxgiFormats.unknown,
    this.resourceDimension = DdsResourceDimensions.unknown,
    this.miscFlag = 0x0,
    this.arraySize = 0x0,
    this.miscFlags2 = DdsAlphaModes.unknown,
  });
}
