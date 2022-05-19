import 'package:device_preview/device_preview.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../../../../logic/bloc/bloc/app_bloc.dart';
import '../../../router/app_router.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child: OKToast(
          child: MaterialApp(
            builder: DevicePreview.appBuilder,
            theme: AppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            home: FlowBuilder<AppState>(
              state: context.select((AppBloc bloc) => bloc.state),
              onGeneratePages: onGenerateAppViewPages,
            ),
          ),
        ),
      );
    });
  }
}
