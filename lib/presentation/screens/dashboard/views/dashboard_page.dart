import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../cubit/dashboard_cubit.dart';
import 'dashboard_form.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: DashboardPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWidget(),
        backgroundColor: kmainBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: SafeArea(
            child: BlocProvider(
              create: (_) =>
                  DashboardCubit(context.read<AuthenticationRepository>()),
              child: const DashboardForm(),
            ),
          ),
        ));
  }
}

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  const AppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Icon(
        Icons.hexagon,
        color: kTextBlackColor,
      ),
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: kTextBlackColor, //change your color here
      ),
      backgroundColor: kmainBackgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
