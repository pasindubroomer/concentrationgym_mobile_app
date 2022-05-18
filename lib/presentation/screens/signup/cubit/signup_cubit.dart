import 'package:bloc/bloc.dart';
import 'package:concentrationgym_mobile_app/core/exceptions/firebase_auth_exception.dart';
import 'package:concentrationgym_mobile_app/core/form_validations/confirm_password.dart';
import 'package:concentrationgym_mobile_app/core/form_validations/password.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../../core/form_validations/email.dart';
import '../../../../data/repositories/authentication_repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthenticationRepository _authenticationRepository;

  SignupCubit(this._authenticationRepository) : super(const SignupState());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
        email: email,
        status:
            Formz.validate([email, state.password, state.confirmPassword])));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmPassword = ConfirmPassword.dirty(
        password: password.value, value: state.confirmPassword.value);

    emit(state.copyWith(
        email: state.email,
        password: password,
        confirmPassword: confirmPassword,
        status:
            Formz.validate([state.email, password, state.confirmPassword])));
  }

  void confirmPasswordChanged(String value) {
    final confirmPassword =
        ConfirmPassword.dirty(password: state.password.value, value: value);
    emit(state.copyWith(
        email: state.email,
        confirmPassword: confirmPassword,
        password: state.password,
        status:
            Formz.validate([state.email, confirmPassword, state.password])));
  }

  Future<void> singupWithCredentials() async {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final confirmPassword = ConfirmPassword.dirty(
        value: state.confirmPassword.value, password: password.value);

    emit(state.copyWith(
        email: email,
        confirmPassword: confirmPassword,
        password: password,
        status: Formz.validate([email, password, confirmPassword])));
    if (state.status.isValid) {
      try {
        emit(state.copyWith(status: FormzStatus.submissionInProgress));
        await _authenticationRepository.signUp(
            email: state.email.value, password: state.password.value);

        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } on SignUpWithEmailAndPasswordFailure catch (e) {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure, errorMessage: e.message));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
