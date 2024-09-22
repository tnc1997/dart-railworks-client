import '../../common/exceptions/railworks_client_exception.dart';

class DdsPixelFormatInvalidException extends RailWorksClientException {
  const DdsPixelFormatInvalidException([
    String? message,
  ]) : super(message);

  @override
  String toString() {
    final buffer = StringBuffer('DdsPixelFormatInvalidException');

    if (message != null) {
      buffer.write(': $message');
    }

    return buffer.toString();
  }
}
