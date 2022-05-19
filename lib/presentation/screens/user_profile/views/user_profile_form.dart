import 'package:concentrationgym_mobile_app/core/constants/enums.dart';
import 'package:concentrationgym_mobile_app/presentation/screens/user_profile/views/user_profile_page.dart';
import 'package:concentrationgym_mobile_app/presentation/widgets/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/default_size.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/error_page.dart';
import '../cubit/cubit/user_profile_cubit.dart';

class UserProfileForm extends StatelessWidget {
  const UserProfileForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserProfileCubit, UserProfileState>(
        listener: (context, state) {
          if (state.loadingState == ProcessingStatus.exception) {
            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const ErrorScreen()),
                (route) => false);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                showSnackbar(
                    state.errorMessage ?? state.errorMessage.toString()),
              );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              BlocBuilder<UserProfileCubit, UserProfileState>(
                builder: (context, state) {
                  if (state.loadingState == ProcessingStatus.loading) {
                    return const Center(
                      child: LoadingScreen(),
                    );
                  } else if (state.loadingState == ProcessingStatus.error) {
                    return SizedBox(
                        width: 100.w,
                        height: 100.h,
                        child: const Center(child: Text("Error")));
                  } else {
                    return FadeIn(
                      child: Column(
                        children: [
                          buildProfileImage(),
                          buildEmail(state, context),
                          SizedBox(
                            height: 1.h,
                          ),
                          buildEditBio(context),
                          SizedBox(
                            height: 1.h,
                          ),
                          buildCommunity(context, state),
                          SizedBox(
                            height: 3.h,
                          ),
                          buildFollowers(context, state),
                          SizedBox(
                            height: 3.h,
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              BlocBuilder<UserProfileCubit, UserProfileState>(
                builder: (context, state) {
                  if (state.loadingState == ProcessingStatus.loading) {
                    return const Center(
                      child: LoadingScreen(),
                    );
                  } else if (state.loadingState == ProcessingStatus.error) {
                    return SizedBox(
                        width: 100.w,
                        height: 100.h,
                        child: const Center(child: Text("Error")));
                  } else {
                    return Column(
                      children: [
                        ToggleButtons(
                          borderColor: Colors.black,
                          fillColor: Colors.grey,
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
                            context
                                .read<UserProfileCubit>()
                                .toggleButtonChanged(index);
                          },
                          isSelected: state.toggleButtonSelectionList,
                        ),
                      ],
                    );
                  }
                },
              ),
              SizedBox(
                height: 3.h,
              ),
              BlocBuilder<UserProfileCubit, UserProfileState>(
                buildWhen: (previous, current) =>
                    previous.toggleButtonSelectedIndex !=
                    current.toggleButtonSelectedIndex,
                builder: (context, state) {
                  if (state.loadingState == ProcessingStatus.loading) {
                    return const Center(
                      child: LoadingScreen(),
                    );
                  } else if (state.toggleButtonSelectedIndex == 0) {
                    return Container();
                  } else {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildStatusWidget(
                                context,
                                state,
                                "MORNING",
                                "ROUTING",
                                state.userDailyStatusModel!.dailyMorningRouting
                                    .toString()),
                            buildStatusWidget(
                                context,
                                state,
                                "EVENING",
                                "ROUTING",
                                state.userDailyStatusModel!.dailyEveningRouting
                                    .toString()),
                            buildStatusWidget(
                                context,
                                state,
                                "GOALIE",
                                "SENSE",
                                state.userDailyStatusModel!.dailyGoalieSense
                                    .toString()),
                            buildStatusWidget(
                                context,
                                state,
                                "SKILL",
                                "VISUALIZATION",
                                state.userDailyStatusModel!
                                    .dailySkillVisualization
                                    .toString()),
                            buildStatusWidget(
                                context,
                                state,
                                "WINNING",
                                "STREAK",
                                state.userDailyStatusModel!.dailyWinningStreak
                                    .toString()),
                          ],
                        )
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }

  Container buildEditBio(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: kDefaultBlueColor),
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

  Column buildStatusWidget(BuildContext context, UserProfileState state,
      String top, String bottom, String value) {
    return Column(
      children: [
        Text(top,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(fontWeight: FontWeight.w500)),
        Text(bottom,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(fontWeight: FontWeight.w500)),
        FittedBox(
          child: Text(
            value,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }

  FittedBox buildEmail(UserProfileState state, BuildContext context) {
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

  Row buildFollowers(BuildContext context, UserProfileState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              "FOLLOWING",
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: kTextBlackColor.withOpacity(0.4)),
            ),
            Text(
              state.userProfileModel!.following.toString(),
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.w500, color: kTextBlackColor),
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
                  fontWeight: FontWeight.w500,
                  color: kTextBlackColor.withOpacity(0.4)),
            ),
            Text(
              state.userProfileModel!.followers.toString(),
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.w500, color: kTextBlackColor),
            )
          ],
        )
      ],
    );
  }

  Widget buildCommunity(BuildContext context, UserProfileState state) {
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
              .bodySmall!
              .copyWith(fontWeight: FontWeight.w600, color: kDefaultBlackColor),
        )
      ],
    );
  }

  CircularPercentIndicator buildProfileImage() {
    return CircularPercentIndicator(
      radius: 16.w,
      lineWidth: 2.w,
      animation: true,
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
}
