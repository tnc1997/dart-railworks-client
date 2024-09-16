import 'package:xml/xml.dart';

import '../../common/exceptions/railworks_client_exception.dart';

class XmlElementInvalidException extends RailWorksClientException {
  final XmlElement? element;

  const XmlElementInvalidException([
    String? message,
    this.element,
  ]) : super(message);

  @override
  String toString() {
    final buffer = StringBuffer('XmlElementInvalidException');

    if (message != null) {
      buffer.write(': $message');
    }

    return buffer.toString();
  }
}
