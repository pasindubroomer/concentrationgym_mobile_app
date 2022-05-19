import 'package:concentrationgym_mobile_app/core/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/colors.dart';
import '../../../data/repositories/common_repository.dart';
import '../../widgets/app_bar.dart';
import 'cubit/profile_cubit.dart';
import 'profile_daily_status/cubit/profile_daily_status_cubit.dart';
import 'profile_daily_status/widget_profile_daily_status.dart';
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
          )
        ],
        child: SafeArea(
            child: Scaffold(
                backgroundColor: kmainBackgroundColor,
                appBar: const AppBarWidget(),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          return _buildBioContent(context, state);
                        },
                      ),
                      BlocBuilder<UserStatusCubit, UserStatusState>(
                        builder: (context, state) {
                          return _buildButtonsContent(context, state);
                        },
                      ),
                    ],
                  ),
                ))));
  }
}

Widget _buildBioContent(BuildContext context, ProfileState state) {
  if (state.mainProcessingState == ProcessingStatus.success) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 1.h,
        ),
        _buildProfileImage(),
        SizedBox(
          height: 1.h,
        ),
        _buildEditBio(context),
        SizedBox(
          height: 1.h,
        ),
        _buildEmail(state, context),
        SizedBox(
          height: 1.h,
        ),
        _buildCommunity(context, state),
        SizedBox(
          height: 2.h,
        ),
        _buildFollowers(context, state),
        SizedBox(
          height: 1.h,
        ),
        SizedBox(
          height: 1.h,
        ),
      ],
    );
  } else if (state.mainProcessingState == ProcessingStatus.loading) {
    return Stack(
      children: [
        SizedBox(
          width: 100.w,
          height: 100.h,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  } else if (state.mainProcessingState == ProcessingStatus.error) {
    return const Center(
      child: Text('Cannot load data'),
    );
  } else {
    return const Center(
      child: Text('Unknown state'),
    );
  }
}

Widget _buildButtonsContent(BuildContext context, UserStatusState state) {
  if (state.processingState == ProcessingStatus.success) {
    return Column(
      children: [
        SizedBox(
          height: 1.h,
        ),
        _buildToggleButton(context, state),
        SizedBox(
          height: 1.h,
        ),
        const UserStatusWidget(),
      ],
    );
  } else if (state.processingState == ProcessingStatus.error) {
    return const Center(
      child: Text('Cannot load data'),
    );
  } else {
    return const Center(
      child: Text('Unknown state'),
    );
  }
}

ToggleButtons _buildToggleButton(BuildContext context, UserStatusState state) {
  return ToggleButtons(
    borderColor: Colors.black,
    fillColor: kDefaultBlueColor,
    borderWidth: 2,
    selectedBorderColor: Colors.black,
    selectedColor: Colors.white,
    borderRadius: BorderRadius.circular(0),
    children: <Widget>[
      SizedBox(
        width: 25.w,
        child: Center(
          child: Text(
            'BADGES',
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      SizedBox(
        width: 25.w,
        child: Center(
          child: Text(
            'EXERCISES',
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ],
    onPressed: (int index) {
      context.read<UserStatusCubit>().toggleButtonChanged(index);
    },
    isSelected: state.toggleButtonSelectionList,
  );
}

Container _buildEditBio(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2), color: kDefaultBlueColor),
    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
    child: Text(
      "EDIT BIO",
      style: Theme.of(context)
          .textTheme
          .labelSmall!
          .copyWith(fontWeight: FontWeight.w500, color: kDefaultWhiteColor),
    ),
  );
}

FittedBox _buildEmail(ProfileState state, BuildContext context) {
  return FittedBox(
    child: Text(
      state.userProfileModel!.email.toString(),
      style: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(fontWeight: FontWeight.w500),
    ),
  );
}

Row _buildFollowers(BuildContext context, ProfileState state) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Column(
        children: [
          Text(
            "FOLLOWING",
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            state.userProfileModel!.following.toString(),
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(fontWeight: FontWeight.bold),
          )
        ],
      ),
      SizedBox(
        width: 5.w,
      ),
      Column(
        children: [
          Text(
            "FOLLOWERS",
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            state.userProfileModel!.followers.toString(),
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(fontWeight: FontWeight.bold),
          )
        ],
      )
    ],
  );
}

Widget _buildCommunity(BuildContext context, ProfileState state) {
  if (state.userProfileModel!.community.toString().isEmpty) {
    return Container();
  }
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              'assets/images/level.png',
              width: 8.w,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            width: 1.w,
          ),
          Text(
            "SUPPORTER OF ",
            style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w500, color: kDefaultBlueColor),
          )
        ],
      ),
      Text(
        state.userProfileModel!.community.toString(),
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontWeight: FontWeight.w600, color: kDefaultBlackColor),
      )
    ],
  );
}

CircularPercentIndicator _buildProfileImage() {
  return CircularPercentIndicator(
    radius: 16.w,
    lineWidth: 2.w,
    animation: false,
    percent: 0.7,
    center: Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(5.w),
          child: ClipOval(
            child: Image.asset(
              'assets/images/user.jpg',
              width: 25.w,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
            bottom: 3.h,
            right: 5.w,
            child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: kDefaultWhiteColor,
                      width: 3,
                    ),
                    color: kDefaultBlackColor),
                child: Icon(
                  Icons.edit,
                  size: 4.w,
                  color: kDefaultWhiteColor,
                )))
      ],
    ),
    circularStrokeCap: CircularStrokeCap.round,
    progressColor: kDefaultBlueColor,
  );
}
