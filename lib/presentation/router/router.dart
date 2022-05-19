import 'package:concentrationgym_mobile_app/presentation/screens/login/login.dart';
import 'package:concentrationgym_mobile_app/presentation/screens/user_profile/views/user_profile_page.dart';
import 'package:flutter/material.dart';

import '../screens/dashboard/views/dashboard_page.dart';
import '../screens/splash/sc_splash.dart';

class AppRouter {
  static const String HOME = '/';
  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String USER_PROFILE = '/user_profile';
  static const String SHOW_INFO = '/show_info';
  static const String BOOK_TIME_SLOT = '/book_time_slot';
  static const String BOOK_SEAT_TYPE = '/book_seat_type';
  static const String BOOK_SEAT_SLOT = '/book_seat_slot';
  static const String LIST_ALL_CINE = '/list_all_cine';
  static const String REGISTER = '/register';
  static const String LIST_MY_TICKET = '/list_my_ticket';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME:
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      case SPLASH:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case LOGIN:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case USER_PROFILE:
        return MaterialPageRoute(builder: (_) => const UserProfiledPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
