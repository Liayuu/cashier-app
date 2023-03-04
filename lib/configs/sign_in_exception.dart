class SignInException {
  final String message;
  SignInException([
    this.message = "An unknown error occurred",
  ]);

  factory SignInException.code(String code) {
    switch (code) {
      case '':
        return SignInException('');
      default:
        return SignInException();
    }
  }
}
