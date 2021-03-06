import 'package:concentrationgym_mobile_app/data/repositories/common_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors.dart';

import '../cubit/cubit/user_profile_cubit.dart';

import 'user_profile_form.dart';

class UserProfiledPage extends StatelessWidget {
  const UserProfiledPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: UserProfiledPage());

  @override
  Widget build(BuildContext context) {
    final commonRepository = CommonRepository();
    return Scaffold(
        appBar: const BioAppBarWidget(),
        backgroundColor: kmainBackgroundColor,
        body: SafeArea(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<UserProfileCubit>(
                create: (BuildContext context) =>
                    UserProfileCubit(commonRepository)..getUserData(),
              ),
            ],
            child: const UserProfileForm(),
          ),
        ));
  }
}

class BioAppBarWidget extends StatelessWidget with PreferredSizeWidget {
  const BioAppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Bio",
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      elevation: 1,
      centerTitle: true,
      leading: const Icon(Icons.alarm),
      actions: [
        const Icon(
          Icons.settings,
          size: 30,
        ),
        SizedBox(
          width: 2.w,
        )
      ],
      iconTheme: IconThemeData(
        color: kTextBlackColor, //change your color here
      ),
      backgroundColor: kmainBackgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
