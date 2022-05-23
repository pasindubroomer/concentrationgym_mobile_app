import 'package:concentrationgym_mobile_app/presentation/router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';

import 'app/GmaApp.dart';
import 'app_config.dart';
import 'data/models/user_profile_model.dart';
import 'data/models/user_routing_session_history_model.dart';

void main() async {
  GMAApp.initSystemDefault();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  //Hive.deleteFromDisk();

  Hive.registerAdapter(UserProfileModelAdapter());
  Hive.registerAdapter(UserRoutingSessionHistoryModelAdapter());

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
