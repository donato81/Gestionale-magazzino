class AppException implements Exception {
  final String message;
  final String? technicalMessage;

  const AppException(
    this.message, {
    this.technicalMessage,
  });

  @override
  String toString() {
    if (technicalMessage != null) {
      return 'AppException: $message ($technicalMessage)';
    }
    return 'AppException: $message';
  }
}
