import 'package:bloc/bloc.dart';
import 'package:concentrationgym_mobile_app/presentation/router/router.dart';
import 'package:concentrationgym_mobile_app/presentation/screens/app_screen/view/app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'app/GmaApp.dart';
import 'app_config.dart';
import 'data/repositories/authentication_repository.dart';
import 'logic/app_bloc_observer.dart';

void main() async {
  GMAApp.initSystemDefault();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    AppConfig(
      appName: "GMA APP",
      debugTag: false,
      flavorName: "dev",
      initialRoute: AppRouter.LOGIN,
      child: GMAApp.runWidget(),
    ),
  );
}
