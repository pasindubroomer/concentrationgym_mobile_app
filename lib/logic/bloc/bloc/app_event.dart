part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppUserChanged extends AppEvent {
  final UserModel user;

  const AppUserChanged(this.user);

  @override
  List<Object> get props => [user];
}

class AppLogoutRequested extends AppEvent {}

class AppRouteChanged extends AppEvent {
  final String route;

  const AppRouteChanged({this.route = "/"});

  @override
  List<Object> get props => [route];
}
