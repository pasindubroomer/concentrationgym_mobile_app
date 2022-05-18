import 'package:concentrationgym_mobile_app/presentation/screens/login/login.dart';
import 'package:concentrationgym_mobile_app/presentation/screens/testview.dart';
import 'package:flutter/widgets.dart';

import '../../core/constants/enums.dart';
import '../../logic/bloc/bloc/app_bloc.dart';
import '../screens/layout.dart';
import '../screens/user_profile/views/user_profile_page.dart';

List<Page> onGenerateAppViewPages(AppState state, List<Page<dynamic>> pages) {
  if (state.appAuthenticatedStatus == AppAuthenticatedStatus.authenticated) {
    if (state.route == "/") {
      return [UserProfiledPage.page()];
    } else if (state.route == "test") {
      return [TestView.page()];
    } else {
      return [MyStatefulWidget.page( )];
    }
  } else {
    return [LoginPage.page()];
  }
}
