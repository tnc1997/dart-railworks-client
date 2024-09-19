import '../../common/exceptions/railworks_client_exception.dart';

class DdsRgbBitCountRequiredException extends RailWorksClientException {
  const DdsRgbBitCountRequiredException([
    String? message,
  ]) : super(message);

  @override
  String toString() {
    final buffer = StringBuffer('DdsRgbBitCountRequiredException');

    if (message != null) {
      buffer.write(': $message');
    }

    return buffer.toString();
  }
}
