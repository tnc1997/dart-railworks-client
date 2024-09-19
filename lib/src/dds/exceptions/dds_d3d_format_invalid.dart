import '../../common/exceptions/railworks_client_exception.dart';

class DdsD3dFormatInvalid extends RailWorksClientException {
  final int? format;

  const DdsD3dFormatInvalid([
    String? message,
    this.format,
  ]) : super(message);

  @override
  String toString() {
    final buffer = StringBuffer('DdsD3dFormatInvalid');

    if (message != null) {
      buffer.write(': $message');
    }

    return buffer.toString();
  }
}
