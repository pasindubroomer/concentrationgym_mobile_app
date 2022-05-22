import 'package:concentrationgym_mobile_app/core/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/colors.dart';
import 'cubit/profile_routing_session_cubit.dart';

class UserRoutingSessionHistory extends StatelessWidget {
  const UserRoutingSessionHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRoutingSessionHistoryCubit,
        UserRoutingSessionHistoryState>(
      builder: (context, state) {
        if (state.processingState == ProcessingStatus.success) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 20.0.h,
              maxHeight: 160.0.h,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: kDefaultGreyColor,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.account_circle,
                                  color: kDefaultBlueColor,
                                ),
                                Text(
                                    DateFormat('yyyy-MM-dd hh:mm:ss')
                                        .format(state
                                            .userRoutingSessionHistoryModel![
                                                index]
                                            .date!
                                            .toDate())
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(fontSize: 9.sp))
                              ]),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            "Just did a breathing session " +
                                state.userRoutingSessionHistoryModel![index]
                                    .sessionType
                                    .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontSize: 9.sp),
                          ),
                          Text(
                              "- " +
                                  state.userRoutingSessionHistoryModel![index]
                                      .exerciseCount
                                      .toString() +
                                  " EXERCISES",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontSize: 9.sp)),
                          Text(
                              "- " +
                                  state.userRoutingSessionHistoryModel![index]
                                      .average
                                      .toString() +
                                  " MINUTE AVERAGE",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontSize: 9.sp)),
                          Text(
                              "- " +
                                  state.userRoutingSessionHistoryModel![index]
                                      .longestRound
                                      .toString() +
                                  " LONGEST AVERAGE",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontSize: 9.sp))
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: state.userRoutingSessionHistoryModel!.length,
            ),
          );
        } else {
          return const Center(
              child: Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ));
        }
      },
    );
  }
}
