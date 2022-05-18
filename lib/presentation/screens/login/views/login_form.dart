import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:formz/formz.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/default_size.dart';
import '../../../widgets/custom_snackbar.dart';
import '../cubit/login_cubit.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
        child: SingleChildScrollView(
          child: Padding(
            padding: kPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 8.h),
                const _LoginTitle(),
                SizedBox(height: 5.h),
                const _EmailInput(),
                const SizedBox(height: 8),
                const _PasswordInput(),
                SizedBox(height: 10.h),
                const _LoginButton(),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            context.loaderOverlay.hide();
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                showSnackbar(state.errorMessage ?? "Authentication Failure"),
              );
          } else if (state.status.isSubmissionInProgress) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
        });
  }
}

class _LoginTitle extends StatelessWidget {
  const _LoginTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Welcome back!",
          style: Theme.of(context).textTheme.headline5,
        ),
        Text("We're so excited to see you again!",
            style: Theme.of(context).textTheme.bodySmall)
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key("loginForm_emailInput_textField"),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              fillColor: kTextFieldBackgroundColor,
              filled: true,
              prefixIcon: const Icon(Icons.email_outlined),
              hintText: '',
              labelText: 'Email',
              border: InputBorder.none,
              errorText:
                  (state.email.invalid) ? 'A valid login is required.' : null),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key("loginForm_passwordInput_textField"),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          keyboardType: TextInputType.text,
          obscureText: true,
          obscuringCharacter: "*",
          decoration: InputDecoration(
              fillColor: kTextFieldBackgroundColor,
              filled: true,
              prefixIcon: const Icon(Icons.lock_clock_outlined),
              labelText: 'Password',
              border: InputBorder.none,
              errorText: (state.password.invalid)
                  ? 'A valid password is required.'
                  : null),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return SizedBox(
          width: double.maxFinite,
          child: ElevatedButton(
            key: const Key('loginForm_continue_raisedButton'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              context.read<LoginCubit>().loginWithCredentials();
            },
            child: const Text('Login'),
          ),
        );
      },
    );
  }
}
