import 'railworks_client_exception.dart';

class RailWorksEndOfStreamException extends RailWorksClientException {
  const RailWorksEndOfStreamException([
    String? message,
  ]) : super(message);

  @override
  String toString() {
    final buffer = StringBuffer('RailWorksEndOfStreamException');

    if (message != null) {
      buffer.write(': $message');
    }

    return buffer.toString();
  }
}
