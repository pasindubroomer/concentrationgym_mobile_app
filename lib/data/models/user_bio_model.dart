import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserBioModel extends Equatable {
  final String? uid;
  final String? team;
  final String? league;
  final String? favouriteGoalie;
  final String? careerTargets;
  final String? other;

  const UserBioModel(
      {this.uid,
      this.team,
      this.league,
      this.favouriteGoalie,
      this.careerTargets,
      this.other});

  @override
  List<Object?> get props =>
      [uid, team, league, favouriteGoalie, careerTargets, other];

  UserBioModel copyWith({
    String? uid,
    String? team,
    String? league,
    String? favouriteGoalie,
    String? careerTargets,
    String? other,
  }) {
    return UserBioModel(
      uid: uid ?? this.uid,
      team: team ?? this.team,
      league: league ?? this.league,
      favouriteGoalie: favouriteGoalie ?? this.favouriteGoalie,
      careerTargets: careerTargets ?? this.careerTargets,
      other: other ?? this.other,
    );
  }

  static const empty = UserBioModel(uid: "");

  factory UserBioModel.fromJson(Map<String, dynamic> json) {
    return UserBioModel(
      team: json['team'] as String?,
      league: json['league'] as String?,
      favouriteGoalie: json['favourite_goalie'] as String?,
      careerTargets: json['career_targets'] as String?,
      other: json['other'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'team': team,
        'league': league,
        'favourite_goalie': favouriteGoalie,
        'career_targets': careerTargets,
        'other': other,
      };
}
