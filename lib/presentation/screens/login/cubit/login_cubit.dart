import 'package:bloc/bloc.dart';
import 'package:concentrationgym_mobile_app/core/exceptions/firebase_auth_exception.dart';
import 'package:concentrationgym_mobile_app/core/form_validations/password.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../../core/form_validations/email.dart';
import '../../../../data/repositories/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginCubit(this._authenticationRepository) : super(const LoginState());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
        email: email, status: Formz.validate([email, state.password])));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
        email: state.email,
        password: password,
        status: Formz.validate([state.email, password])));
  }

  Future<void> loginWithCredentials() async {
    final email = Email.dirty(state.email.value);
    final passwords = Password.dirty(state.password.value);
    emit(state.copyWith(
        email: email,
        password: passwords,
        status: Formz.validate([email, passwords])));

    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _authenticationRepository.logInWithEmailAndPassword(
            email: email.value, password: passwords.value);

        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } on LogInWithEmailAndPasswordFailure catch (e) {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure, errorMessage: e.message));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
