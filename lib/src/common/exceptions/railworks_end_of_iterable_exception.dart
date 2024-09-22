import 'railworks_client_exception.dart';

class RailWorksEndOfIterableException extends RailWorksClientException {
  const RailWorksEndOfIterableException([
    String? message,
  ]) : super(message);

  @override
  String toString() {
    final buffer = StringBuffer('RailWorksEndOfIterableException');

    if (message != null) {
      buffer.write(': $message');
    }

    return buffer.toString();
  }
}
