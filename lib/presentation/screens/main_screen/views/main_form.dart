import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/default_size.dart';
import '../../../widgets/custom_snackbar.dart';
import '../cubit/login_cubit.dart';

class MainForm extends StatelessWidget {
  const MainForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
        buildWhen: (previous, current) => true,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: kPaddingDefault,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                );
        },
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
/*             alertSuccess(
                    context, (state.errorMessage ?? 'Authentication Failure'))
                .show(); */
/*             ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Authentication Failure'),
                ),
              ); */
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
    return SizedBox(
      height: 60.h,
      child: SvgPicture.asset('assets/images/fitness.svg'),
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
              prefixIcon: const Icon(Icons.email),
              labelStyle: const TextStyle(fontWeight: FontWeight.w700),
              hintText: 'Email',
              floatingLabelBehavior: FloatingLabelBehavior.never,
              errorText:
                  state.email.invalid ? 'Please enter valid email' : null),
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
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.lock),
              labelStyle: TextStyle(fontWeight: FontWeight.w700),
              hintText: 'Password',
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ));
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
              textStyle: (Theme.of(context).textTheme.headline6)!
                  .copyWith(fontWeight: FontWeight.w600),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              if (state.email.valid) {
                context
                    .read<LoginCubit>()
                    .loginWithCredentials("pasindu14@gmail.com", "adassad");
              }
            },
            child: const Text('Login'),
          ),
        );
      },
    );
  }
}
