import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:concentrationgym_mobile_app/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

import '../../../core/constants/enums.dart';
import '../../../data/repositories/authentication_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<UserModel> _userSubscription;

  AppBloc({required authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(authenticationRepository.currentUser.isNotEmpty
            ? const AppState().copyWith(
                user: authenticationRepository.currentUser,
                appAuthenticatedStatus: AppAuthenticatedStatus.authenticated)
            : const AppState()) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    on<AppRouteChanged>(_onRouteChanged);

    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AppUserChanged(user)),
    );
  }

  FutureOr<void> _onLogoutRequested(
      AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  FutureOr<void> _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    emit(event.user.isNotEmpty
        ? state.copyWith(user: event.user,appAuthenticatedStatus: AppAuthenticatedStatus.authenticated)
        : const AppState());
  }

  FutureOr<void> _onRouteChanged(
      AppRouteChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(route: event.route));
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
