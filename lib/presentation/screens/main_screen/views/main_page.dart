import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../cubit/login_cubit.dart';
import 'main_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kmainBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: SafeArea(
            child: BlocProvider(
              create: (_) =>
                  LoginCubit(context.read<AuthenticationRepository>()),
              child: const MainForm(),
            ),
          ),
        ));
  }
}
