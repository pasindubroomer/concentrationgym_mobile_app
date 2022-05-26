import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 4)
class TaskModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final bool completeStatus;
  @HiveField(2)
  final bool isReward;
  TaskModel(
      {required this.id, required this.completeStatus, required this.isReward});
}
