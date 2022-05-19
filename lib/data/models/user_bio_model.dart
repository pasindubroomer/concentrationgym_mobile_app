import 'package:equatable/equatable.dart';

class UserBioModel extends Equatable {
  final String? uid;
  final String? team;
  final String? league;
  final String? favouriteGoalie;
  final String? goalieCareerTargets;
  final String? other;

  const UserBioModel(
      {this.uid,
      this.team,
      this.league,
      this.favouriteGoalie,
      this.goalieCareerTargets,
      this.other});

  @override
  List<Object?> get props =>
      [uid, team, league, favouriteGoalie, goalieCareerTargets, other];

  UserBioModel copyWith({
    String? uid,
    String? team,
    String? league,
    String? favouriteGoalie,
    String? goalieCareerTargets,
    String? other,
  }) {
    return UserBioModel(
      uid: uid ?? this.uid,
      team: team ?? this.team,
      league: league ?? this.league,
      favouriteGoalie: favouriteGoalie ?? this.favouriteGoalie,
      goalieCareerTargets: goalieCareerTargets ?? this.goalieCareerTargets,
      other: other ?? this.other,
    );
  }

  static const empty = UserBioModel(uid: "");
}
