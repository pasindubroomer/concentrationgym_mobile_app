import 'package:concentrationgym_mobile_app/presentation/router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import 'app/GmaApp.dart';
import 'app_config.dart';

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
