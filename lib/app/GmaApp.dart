import 'package:concentrationgym_mobile_app/data/repositories/common_repository.dart';
import 'package:concentrationgym_mobile_app/logic/bloc/bloc/app_bloc.dart';
import 'package:concentrationgym_mobile_app/presentation/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:flutter_spinkit/flutter_spinkit.dart";
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../app_config.dart';
import '../core/constants/colors.dart';
import '../core/constants/enums.dart';
import '../core/themes/app_theme.dart';
import '../data/repositories/authentication_repository.dart';
import '../data/repositories/firebase_storage_repository.dart';
import '../presentation/router/router.dart';
import '../presentation/screens/profile/sc_profile.dart';
import '../presentation/screens/splash/sc_splash.dart';
import '../presentation/screens/twenty_day_challenge/sc_twenty_day_challenge.dart';

class GMAApp extends StatelessWidget {
  const GMAApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = AppConfig.of(context)!;
    return Sizer(builder: (context, constraints, orientation) {
      return GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayColor: Colors.white,
        overlayWidget: Center(
          child: SpinKitCircle(
            color: kDefaultBlackColor,
            size: 25.0,
          ),
        ),
        overlayOpacity: 1,
        child: MaterialApp(
          debugShowCheckedModeBanner: config.debugTag,
          theme: AppTheme.lightTheme,
          onGenerateRoute: AppRouter.generateRoute,
          home: BlocBuilder<AppBloc, AppState>(
            buildWhen: (previous, current) =>
                previous.appAuthenticatedStatus !=
                current.appAuthenticatedStatus,
            builder: (context, state) {
              if (state.appAuthenticatedStatus ==
                  AppAuthenticatedStatus.uninitialized) {
                return SplashScreen();
              } else if (state.appAuthenticatedStatus ==
                  AppAuthenticatedStatus.unauthenticated) {
                return const LoginPage();
              } else if (state.appAuthenticatedStatus ==
                  AppAuthenticatedStatus.authenticated) {
                return const TwentyDayChallengeScreen();
              }
              return const Center(child: Text('Unhandled State'));
            },
          ),
        ),
      );
    });
  }

  static void initSystemDefault() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: kDefaultBlueColor,
      ),
    );
  }

  static Widget runWidget() {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
            create: (context) => AuthenticationRepository()),
        RepositoryProvider<CommonRepository>(
            create: (context) => CommonRepository()),
        RepositoryProvider<FirebaseStorageRepository>(
            create: (context) => FirebaseStorageRepository())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                AppBloc(authenticationRepository: AuthenticationRepository()),
          ),
        ],
        child: const GMAApp(),
      ),
    );
  }
}
