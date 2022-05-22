import 'package:concentrationgym_mobile_app/presentation/screens/profile/profile_image/widget_profile_image.dart';
import 'package:concentrationgym_mobile_app/presentation/screens/profile/widget_bio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/colors.dart';
import '../../../data/repositories/common_repository.dart';
import '../../../data/repositories/firebase_storage_repository.dart';
import '../../widgets/app_bar.dart';
import 'cubit/profile_cubit.dart';
import 'profile_daily_status/cubit/profile_daily_status_cubit.dart';
import 'profile_daily_status/widget_profile_daily_status.dart';
import 'profile_image/cubit/profile_image_cubit.dart';
import 'profile_routing_session/cubit/profile_routing_session_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ProfileCubit>(
            create: (BuildContext context) =>
                ProfileCubit(context.read<CommonRepository>())
                  ..getUserPersonalDetails(),
          ),
          BlocProvider<UserStatusCubit>(
            create: (BuildContext context) =>
                UserStatusCubit(context.read<CommonRepository>())
                  ..getUserDailyStatus(),
          ),
          BlocProvider<UserRoutingSessionHistoryCubit>(
            create: (BuildContext context) =>
                UserRoutingSessionHistoryCubit(context.read<CommonRepository>())
                  ..getUserRoutingSessionHistory(),
          ),
          BlocProvider<ProfileImageCubit>(
            create: (BuildContext context) =>
                ProfileImageCubit(context.read<FirebaseStorageRepository>())
                  ..getProfileImageDownloadUrl(),
          )
        ],
        child: SafeArea(
            child: Scaffold(
                backgroundColor: kmainBackgroundColor,
                appBar: const AppBarWidget(),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      ProfileImage(),
                      Bio(),
                      UserStatusWithHistory(),
                    ],
                  ),
                ))));
  }
}
