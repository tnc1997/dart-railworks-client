import '../../common/exceptions/railworks_client_exception.dart';
import '../models/bin_element.dart';

class BinElementInvalidException extends RailWorksClientException {
  final BinElement? element;

  const BinElementInvalidException([
    String? message,
    this.element,
  ]) : super(message);

  @override
  String toString() {
    final buffer = StringBuffer('BinElementInvalidException');

    if (message != null) {
      buffer.write(': $message');
    }

    return buffer.toString();
  }
}
