import '../../common/exceptions/railworks_client_exception.dart';

class DdsPixelFormatFlagsInvalidException extends RailWorksClientException {
  final int? flags;

  const DdsPixelFormatFlagsInvalidException([
    String? message,
    this.flags,
  ]) : super(message);

  @override
  String toString() {
    final buffer = StringBuffer('DdsPixelFormatFlagsInvalidException');

    if (message != null) {
      buffer.write(': $message');
    }

    return buffer.toString();
  }
}
