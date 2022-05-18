part of 'app_bloc.dart';

class AppState extends Equatable {
  final AppAuthenticatedStatus appAuthenticatedStatus;
  final String route;
  final UserModel user;

  const AppState({
    this.user = UserModel.empty,
    this.appAuthenticatedStatus = AppAuthenticatedStatus.unauthenticated,
    this.route = "/",
  });

  @override
  List<Object?> get props => [appAuthenticatedStatus, route];

  AppState copyWith({
    AppAuthenticatedStatus? appAuthenticatedStatus,
    String? route,
    UserModel? user,
  }) {
    return AppState(
      appAuthenticatedStatus:
          appAuthenticatedStatus ?? this.appAuthenticatedStatus,
      route: route ?? this.route,
      user: user ?? this.user,
    );
  }
}
