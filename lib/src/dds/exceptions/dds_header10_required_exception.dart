import '../../common/exceptions/railworks_client_exception.dart';

class DdsHeader10RequiredException extends RailWorksClientException {
  const DdsHeader10RequiredException([
    String? message,
  ]) : super(message);

  @override
  String toString() {
    final buffer = StringBuffer('DdsHeader10RequiredException');

    if (message != null) {
      buffer.write(': $message');
    }

    return buffer.toString();
  }
}
