import 'railworks_client_exception.dart';

class RailWorksBlobInvalidException extends RailWorksClientException {
  const RailWorksBlobInvalidException([
    String? message,
  ]) : super(message);

  @override
  String toString() {
    final buffer = StringBuffer('RailWorksBlobInvalidException');

    if (message != null) {
      buffer.write(': $message');
    }

    return buffer.toString();
  }
}
