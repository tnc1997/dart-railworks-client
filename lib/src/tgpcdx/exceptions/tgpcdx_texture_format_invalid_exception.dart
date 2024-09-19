import '../../common/exceptions/railworks_client_exception.dart';

class TgpcdxTextureFormatInvalidException extends RailWorksClientException {
  final String? format;

  const TgpcdxTextureFormatInvalidException([
    String? message,
    this.format,
  ]) : super(message);

  @override
  String toString() {
    final buffer = StringBuffer('TgpcdxTextureFormatInvalidException');

    if (message != null) {
      buffer.write(': $message');
    }

    return buffer.toString();
  }
}
