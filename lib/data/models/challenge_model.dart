import 'package:concentrationgym_mobile_app/data/models/task_model.dart';
import 'package:hive/hive.dart';

part 'challenge_model.g.dart';

@HiveType(typeId: 3)
class ChallengeModel {
  @HiveField(0)
  final int challengeId;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int weekNo;
  @HiveField(3)
  final List<TaskModel> taskList;
  @HiveField(4)
  final bool isAllCompleted;

  ChallengeModel({
    required this.challengeId,
    required this.name,
    required this.weekNo,
    required this.taskList,
    required this.isAllCompleted,
  });

  static List<ChallengeModel> get20ChallengeList() {
    List<ChallengeModel> listChallenge = [
      ChallengeModel(
          challengeId: 1,
          name: "20 day challenge",
          weekNo: 1,
          isAllCompleted: false,
          taskList: [
            TaskModel(id: 1, completeStatus: true, isReward: false),
            TaskModel(id: 2, completeStatus: true, isReward: false),
            TaskModel(id: 3, completeStatus: true, isReward: false),
            TaskModel(id: 4, completeStatus: false, isReward: false),
            TaskModel(id: 5, completeStatus: false, isReward: false),
            TaskModel(id: 6, completeStatus: false, isReward: false),
          ]),
    ];

    return listChallenge;
  }
}
