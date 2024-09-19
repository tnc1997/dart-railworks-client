import '../../common/exceptions/railworks_client_exception.dart';

class BinPreludeInvalidException extends RailWorksClientException {
  final int? position;

  const BinPreludeInvalidException([
    String? message,
    this.position,
  ]) : super(message);

  @override
  String toString() {
    final buffer = StringBuffer('BinPreludeInvalidException');

    if (message != null) {
      buffer.write(': $message');
    }

    return buffer.toString();
  }
}
