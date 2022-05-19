import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/enums.dart';
import '../profile_routing_session/cubit/profile_routing_session_cubit.dart';
import '../profile_routing_session/widget_profile_routing_session.dart';
import 'cubit/profile_daily_status_cubit.dart';

class UserStatusWidget extends StatelessWidget {
  const UserStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserStatusCubit, UserStatusState>(
      buildWhen: (previous, current) =>
          previous.toggleButtonSelectedIndex !=
          current.toggleButtonSelectedIndex,
      builder: (context, state) {
        if (state.processingState == ProcessingStatus.loading) {
          return const Center(
              child: Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ));
        } else if (state.toggleButtonSelectedIndex == 0) {
          return Container();
        } else {
          return Column(
            children: [
              SizedBox(
                height: 1.h,
              ),
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
                  buildStatusWidget(context, state, "GOALIE", "SENSE",
                      state.userDailyStatusModel!.dailyGoalieSense.toString()),
                  buildStatusWidget(
                      context,
                      state,
                      "SKILL",
                      "VISUALIZATION",
                      state.userDailyStatusModel!.dailySkillVisualization
                          .toString()),
                  buildStatusWidget(
                      context,
                      state,
                      "WINNING",
                      "STREAK",
                      state.userDailyStatusModel!.dailyWinningStreak
                          .toString()),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              BlocBuilder<UserRoutingSessionHistoryCubit,
                  UserRoutingSessionHistoryState>(
                builder: (context, state) {
                  return _buildUserRoutingSessionHistoryContent(context, state);
                },
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildUserRoutingSessionHistoryContent(
      BuildContext context, UserRoutingSessionHistoryState state) {
    if (state.processingState == ProcessingStatus.success) {
      return const UserRoutingSessionHistory();
    } else if (state.processingState == ProcessingStatus.loading) {
      return Center(
        child: SizedBox(
            width: 4.w, height: 4.w, child: const CircularProgressIndicator()),
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

  Column buildStatusWidget(BuildContext context, UserStatusState state,
      String top, String bottom, String value) {
    return Column(
      children: [
        Text(top,
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(fontWeight: FontWeight.w200, fontSize: 8.sp)),
        Text(bottom,
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(fontWeight: FontWeight.w200, fontSize: 8.sp)),
        FittedBox(
          child: Text(
            value,
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(fontWeight: FontWeight.w200, fontSize: 8.sp),
          ),
        )
      ],
    );
  }
}
