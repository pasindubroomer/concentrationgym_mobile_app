import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../cubit/signup_cubit.dart';
import 'signup_form.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: SignupPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kmainBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: SafeArea(
            child: BlocProvider(
              create: (_) =>
                  SignupCubit(context.read<AuthenticationRepository>()),
              child: const SingupForm(),
            ),
          ),
        ));
  }
}
