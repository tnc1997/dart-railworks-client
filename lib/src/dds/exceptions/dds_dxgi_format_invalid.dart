import '../../common/exceptions/railworks_client_exception.dart';

class DdsDxgiFormatInvalid extends RailWorksClientException {
  final int? format;

  const DdsDxgiFormatInvalid([
    String? message,
    this.format,
  ]) : super(message);

  @override
  String toString() {
    final buffer = StringBuffer('DdsDxgiFormatInvalid');

    if (message != null) {
      buffer.write(': $message');
    }

    return buffer.toString();
  }
}
