import '../../common/exceptions/railworks_client_exception.dart';

class DdsMipMapCountRequiredException extends RailWorksClientException {
  const DdsMipMapCountRequiredException([
    String? message,
  ]) : super(message);

  @override
  String toString() {
    final buffer = StringBuffer('DdsMipMapCountRequiredException');

    if (message != null) {
      buffer.write(': $message');
    }

    return buffer.toString();
  }
}
