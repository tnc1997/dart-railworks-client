import '../../common/exceptions/railworks_client_exception.dart';

class DdsHeaderInvalidException extends RailWorksClientException {
  const DdsHeaderInvalidException([
    String? message,
  ]) : super(message);

  @override
  String toString() {
    final buffer = StringBuffer('DdsHeaderInvalidException');

    if (message != null) {
      buffer.write(': $message');
    }

    return buffer.toString();
  }
}
