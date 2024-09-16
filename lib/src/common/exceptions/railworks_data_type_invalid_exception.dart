import 'railworks_client_exception.dart';

class RailWorksDataTypeInvalidException extends RailWorksClientException {
  final String? dataType;

  const RailWorksDataTypeInvalidException([
    String? message,
    this.dataType,
  ]) : super(message);

  @override
  String toString() {
    final buffer = StringBuffer('RailWorksDataTypeInvalidException');

    if (message != null) {
      buffer.write(': $message');
    }

    return buffer.toString();
  }
}
