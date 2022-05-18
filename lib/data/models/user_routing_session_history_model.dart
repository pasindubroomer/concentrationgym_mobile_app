import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserRoutingSessionHistoryModel extends Equatable {
  final String? uid;
  final double? average;
  final Timestamp? date;
  final int? exerciseCount;
  final double? longestRound;

  const UserRoutingSessionHistoryModel(
      {this.uid,
      this.average,
      this.date,
      this.exerciseCount,
      this.longestRound});

  @override
  List<Object?> get props => [average, date, exerciseCount, longestRound];

  UserRoutingSessionHistoryModel copyWith({
    String? uid,
    double? average,
    Timestamp? date,
    int? exerciseCount,
    double? longestRound,
  }) {
    return UserRoutingSessionHistoryModel(
      uid: uid ?? this.uid,
      average: average ?? this.average,
      date: date ?? this.date,
      exerciseCount: exerciseCount ?? this.exerciseCount,
      longestRound: longestRound ?? this.longestRound,
    );
  }

  factory UserRoutingSessionHistoryModel.fromJson(Map<String, dynamic> json) {
    return UserRoutingSessionHistoryModel(
      average: json['average'] as double?,
      date: json['date'] as Timestamp?,
      exerciseCount: json['exercise_count'] as int?,
      longestRound: json['longest_round'] as double?,
    );
  }

  static const empty = UserRoutingSessionHistoryModel(uid: "");

  Map<String, dynamic> toJson() => <String, dynamic>{
        'average': average,
        'date': date,
        'exercise_count': exerciseCount,
        'longest_round': longestRound,
      };
}
