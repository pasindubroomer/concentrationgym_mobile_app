import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserStatusModel extends Equatable {
  final String? uid;
  final int? dailyMorningRouting;
  final int? dailyEveningRouting;
  final int? dailyGoalieSense;
  final int? dailySkillVisualization;
  final int? dailyWinningStreak;

  const UserStatusModel(
      {this.uid,
      this.dailyMorningRouting,
      this.dailyEveningRouting,
      this.dailyGoalieSense,
      this.dailySkillVisualization,
      this.dailyWinningStreak});

  @override
  List<Object?> get props => [
        uid,
        dailyEveningRouting,
        dailyMorningRouting,
        dailyWinningStreak,
        dailySkillVisualization,
        dailyGoalieSense
      ];

  UserStatusModel copyWith({
    String? uid,
    int? dailyMorningRouting,
    int? dailyEveningRouting,
    int? dailyGoalieSense,
    int? dailySkillVisualization,
    int? dailyWinningStreak,
  }) {
    return UserStatusModel(
      uid: uid ?? this.uid,
      dailyMorningRouting: dailyMorningRouting ?? this.dailyMorningRouting,
      dailyEveningRouting: dailyEveningRouting ?? this.dailyEveningRouting,
      dailyGoalieSense: dailyGoalieSense ?? this.dailyGoalieSense,
      dailySkillVisualization:
          dailySkillVisualization ?? this.dailySkillVisualization,
      dailyWinningStreak: dailyWinningStreak ?? this.dailyWinningStreak,
    );
  }

  static const empty = UserStatusModel(uid: "");

  factory UserStatusModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    return UserStatusModel(
      dailyMorningRouting: snapshot.data()?['dailyMorningRouting'],
      dailyEveningRouting: snapshot.data()?['dailyEveningRouting'],
      dailyGoalieSense: snapshot.data()?['dailyGoalieSense'],
      dailySkillVisualization:
          snapshot.data()?['dailySkillVisualization']?.toInt(),
      dailyWinningStreak: snapshot.data()?['dailyWinningStreak']?.toInt(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (dailyMorningRouting != null) "": dailyMorningRouting,
      if (dailyEveningRouting != null) "": dailyEveningRouting,
      if (dailyGoalieSense != null) "": dailyGoalieSense,
      if (dailySkillVisualization != null) "": dailySkillVisualization,
      if (dailyWinningStreak != null) "": dailyWinningStreak,
    };
  }
}
