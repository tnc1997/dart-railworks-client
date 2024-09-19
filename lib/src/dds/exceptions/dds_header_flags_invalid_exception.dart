import '../../common/exceptions/railworks_client_exception.dart';

class DdsHeaderFlagsInvalidException extends RailWorksClientException {
  final int? flags;

  const DdsHeaderFlagsInvalidException([
    String? message,
    this.flags,
  ]) : super(message);

  @override
  String toString() {
    final buffer = StringBuffer('DdsHeaderFlagsInvalidException');

    if (message != null) {
      buffer.write(': $message');
    }

    return buffer.toString();
  }
}
