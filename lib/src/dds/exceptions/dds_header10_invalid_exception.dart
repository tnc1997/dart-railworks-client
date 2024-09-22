import '../../common/exceptions/railworks_client_exception.dart';

class DdsHeader10InvalidException extends RailWorksClientException {
  const DdsHeader10InvalidException([
    String? message,
  ]) : super(message);

  @override
  String toString() {
    final buffer = StringBuffer('DdsHeader10InvalidException');

    if (message != null) {
      buffer.write(': $message');
    }

    return buffer.toString();
  }
}
