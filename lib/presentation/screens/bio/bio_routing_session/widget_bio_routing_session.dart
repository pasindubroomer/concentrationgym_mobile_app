import 'package:concentrationgym_mobile_app/core/constants/enums.dart';
import 'package:concentrationgym_mobile_app/presentation/screens/bio/bio_routing_session/cubit/bio_routing_session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

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
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return Container(color: Colors.black, height: 0.4.h);
              },
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.red,
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Icon(
                              Icons.account_circle,
                              color: Colors.blue,
                            ),
                            Text("Pasindu Dulanjaya"),
                            Text("12.39")
                          ])
                    ],
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
