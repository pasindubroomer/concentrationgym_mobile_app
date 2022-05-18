part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;
  final String? errorMessage;
  final FormzStatus status;

  const DashboardState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.confirmPassword = const ConfirmPassword.pure(),
      this.errorMessage,
      this.status = FormzStatus.pure});

  @override
  List<Object> get props => [email, password, status, confirmPassword];

  DashboardState copyWith({
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
    String? errorMessage,
    FormzStatus? status,
  }) {
    return DashboardState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
