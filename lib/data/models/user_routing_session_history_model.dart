import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user_routing_session_history_model.g.dart';

@HiveType(typeId: 2)
class UserRoutingSessionHistoryModel extends Equatable {
  @HiveField(0)
  final String? uid;
  @HiveField(1)
  final double? average;
  @HiveField(2)
  final DateTime? date;
  @HiveField(3)
  final int? exerciseCount;
  @HiveField(4)
  final double? longestRound;
  @HiveField(5)
  final int? likes;
  @HiveField(6)
  final int? sessionType;

  const UserRoutingSessionHistoryModel({
    this.uid,
    this.average,
    this.date,
    this.exerciseCount,
    this.longestRound,
    this.likes,
    this.sessionType,
  });

  @override
  List<Object?> get props => [average, date, exerciseCount, longestRound];

  UserRoutingSessionHistoryModel copyWith(
      {String? uid,
      double? average,
      DateTime? date,
      int? exerciseCount,
      double? longestRound,
      int? likes,
      int? sessionType}) {
    return UserRoutingSessionHistoryModel(
      uid: uid ?? this.uid,
      average: average ?? this.average,
      date: date ?? this.date,
      exerciseCount: exerciseCount ?? this.exerciseCount,
      longestRound: longestRound ?? this.longestRound,
      likes: likes ?? this.likes,
      sessionType: sessionType ?? this.sessionType,
    );
  }

  factory UserRoutingSessionHistoryModel.fromJson(Map<String, dynamic> json) {
    return UserRoutingSessionHistoryModel(
      average: json['average'] as double?,
      date: (json['date'] as Timestamp?)!.toDate(),
      exerciseCount: json['exercise_count'] as int?,
      longestRound: json['longest_round'] as double?,
      likes: json['likes'] as int?,
      sessionType: json['session_type'] as int?,
    );
  }

  static const empty = UserRoutingSessionHistoryModel(uid: "");

  Map<String, dynamic> toJson() => <String, dynamic>{
        'average': average,
        'date': date,
        'exercise_count': exerciseCount,
        'longest_round': longestRound,
        'likes': likes,
        'session_type': sessionType,
      };
}
