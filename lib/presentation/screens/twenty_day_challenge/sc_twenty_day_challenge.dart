import 'package:concentrationgym_mobile_app/data/models/task_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/colors.dart';
import '../../../data/models/challenge_model.dart';
import '../../widgets/app_bar.dart';

class TwentyDayChallengeScreen extends StatefulWidget {
  const TwentyDayChallengeScreen({Key? key}) : super(key: key);

  @override
  State<TwentyDayChallengeScreen> createState() =>
      _TwentyDayChallengeScreenState();
}

class _TwentyDayChallengeScreenState extends State<TwentyDayChallengeScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildWeek1Challenge() {
    List<ChallengeModel> taskList = ChallengeModel.get20ChallengeList();
    List<Widget> taskListWidgets = <Widget>[];
    for (var i = 0; i < taskList[0].taskList.length; i++) {
      taskListWidgets.add(_buildChallengeCenter(taskList[0].taskList[i]));
    }
    return Wrap(
        alignment: WrapAlignment.spaceEvenly,
        spacing: 5.w,
        runSpacing: 2.h,
        children: taskListWidgets);
  }

  Widget _buildChallengeCenter(TaskModel task) {
    if (task.completeStatus == true) {
      return _buildCompletedTask();
    } else if (task.isReward) {
      return _buildAllCompletedTask();
    } else {
      return _buildIncompleteTask(task);
    }
  }

  Widget _buildAllCompletedTask() {
    return SvgPicture.asset(
      "assets/images/hexagon.svg",
      fit: BoxFit.contain,
      height: 25.w,
      width: 25.w,
    );
  }

  Widget _buildCompletedTask() {
    return Container(
      height: 25.w,
      width: 25.w,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
      child: Align(
        child: SvgPicture.asset(
          "assets/images/hockey_puck.svg",
          height: 12.w,
          width: 12.w,
        ),
      ),
    );
  }

  Widget _buildIncompleteTask(TaskModel task) {
    return DottedBorder(
      dashPattern: const [8, 4],
      borderType: BorderType.Circle,
      color: Colors.white,
      strokeWidth: 2,
      child: Container(
        height: 25.w,
        width: 25.w,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
        child: Align(
          child: Text(
            task.id.toString(),
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: kmainBackgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 5.h,
              centerTitle: true,
              title: Text(
                "20 Day Challenge",
                style: Theme.of(context).textTheme.headline6,
              ),
              iconTheme: const IconThemeData(
                color: Colors.black, //change your color here
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kDefaultBlueColor,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            "Confidence Rookie",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: kTextWhiteColor, fontSize: 18),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            "5 Minutes",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: kTextWhiteColor, fontSize: 14),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          _buildWeek1Challenge(),
                          SizedBox(
                            height: 2.h,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
