import 'package:formz/formz.dart';

/// Validation errors for the [ConfirmedPassword] [FormzInput].
enum ConfirmPasswordValidationError {
  /// Generic invalid error.
  invalid
}

class ConfirmPassword
    extends FormzInput<String, ConfirmPasswordValidationError> {
  final String password;

  const ConfirmPassword.pure({this.password = ''}) : super.pure('');

  const ConfirmPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  @override
  ConfirmPasswordValidationError? validator(String value) {
    return (password == value && value.isNotEmpty)
        ? null
        : ConfirmPasswordValidationError.invalid;
  }
}
