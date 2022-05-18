import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:formz/formz.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/default_size.dart';
import '../../../widgets/custom_snackbar.dart';
import '../cubit/signup_cubit.dart';

class SingupForm extends StatelessWidget {
  const SingupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
        child: SingleChildScrollView(
          child: Padding(
            padding: kPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 8.h),
                const _SignupTitle(),
                SizedBox(height: 5.h),
                const _EmailInput(),
                const SizedBox(height: 8),
                const _PasswordInput(),
                const SizedBox(height: 8),
                const _ConfirmPasswordInput(),
                SizedBox(height: 10.h),
                const _SignupButton(),
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
          } else if (state.status.isSubmissionSuccess) {
            context.loaderOverlay.hide();
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                showSnackbar("Account created successfully"),
              );
          } else {
            context.loaderOverlay.hide();
          }
        });
  }
}

class _SignupTitle extends StatelessWidget {
  const _SignupTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Sign up!",
          style: Theme.of(context).textTheme.headline5,
        ),
        Text("Create an account its free!",
            style: Theme.of(context).textTheme.bodySmall)
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key("loginForm_emailInput_textField"),
          onChanged: (email) => context.read<SignupCubit>().emailChanged(email),
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
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key("loginForm_passwordInput_textField"),
          onChanged: (password) =>
              context.read<SignupCubit>().passwordChanged(password),
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

class _ConfirmPasswordInput extends StatelessWidget {
  const _ConfirmPasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) =>
          (previous.confirmPassword != current.confirmPassword ||
              previous.password != current.password),
      builder: (context, state) {
        return TextField(
          key: const Key("loginForm_confirmpasswordInput_textField"),
          onChanged: (confirmPassword) => context
              .read<SignupCubit>()
              .confirmPasswordChanged(confirmPassword),
          keyboardType: TextInputType.text,
          obscureText: true,
          obscuringCharacter: "*",
          decoration: InputDecoration(
              fillColor: kTextFieldBackgroundColor,
              filled: true,
              prefixIcon: const Icon(Icons.confirmation_num),
              labelText: 'Confirm Password',
              border: InputBorder.none,
              errorText: (state.confirmPassword.invalid)
                  ? 'A valid password is required.'
                  : null),
        );
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  const _SignupButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return SizedBox(
          width: double.maxFinite,
          child: ElevatedButton(
            key: const Key('singupForm_continue_raisedButton'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              context.read<SignupCubit>().singupWithCredentials();
            },
            child: const Text('Sign up'),
          ),
        );
      },
    );
  }
}
