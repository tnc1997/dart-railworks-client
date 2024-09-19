import '../../common/exceptions/railworks_client_exception.dart';

class DdsFourCcInvalidException extends RailWorksClientException {
  final int? fourCc;

  const DdsFourCcInvalidException([
    String? message,
    this.fourCc,
  ]) : super(message);

  @override
  String toString() {
    final buffer = StringBuffer('DdsFourCcInvalidException');

    if (message != null) {
      buffer.write(': $message');
    }

    return buffer.toString();
  }
}
