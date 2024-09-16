class RailWorksClientException implements Exception {
  final String? message;

  const RailWorksClientException([
    this.message,
  ]);

  @override
  String toString() {
    final buffer = StringBuffer('RailWorksClientException');

    if (message != null) {
      buffer.write(': $message');
    }

    return buffer.toString();
  }
}
