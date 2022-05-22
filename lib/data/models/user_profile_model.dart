import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user_profile_model.g.dart';

@HiveType(typeId: 1)
class UserProfileModel extends Equatable {
  @HiveField(0)
  final String? uid;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? email;
  @HiveField(3)
  final int? followers;
  @HiveField(4)
  final int? following;
  @HiveField(5)
  final String? badge;
  @HiveField(6)
  final String? community;

  const UserProfileModel(
      {this.uid,
      this.name,
      this.email,
      this.followers,
      this.following,
      this.badge,
      this.community});

  UserProfileModel copyWith({
    String? uid,
    String? name,
    String? email,
    int? followers,
    int? following,
    String? badge,
    String? community,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      badge: badge ?? this.badge,
      community: community ?? this.community,
    );
  }

  static const empty = UserProfileModel(uid: "");

  factory UserProfileModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    return UserProfileModel(
      uid: snapshot.data()?['uid'],
      name: snapshot.data()?['name'],
      email: snapshot.data()?['email'],
      followers: snapshot.data()?['followers']?.toInt(),
      following: snapshot.data()?['following']?.toInt(),
      badge: snapshot.data()?['badge'],
      community: snapshot.data()?['community'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "": name,
      if (name != null) "": name,
      if (email != null) "": email,
      if (followers != null) "": followers,
      if (following != null) "": following,
      if (badge != null) "": badge,
      if (community != null) "": community,
    };
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      uid: json['uid'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      followers: json['followers'] as int?,
      following: json['following'] as int?,
      badge: json['badge'] as String?,
      community: json['community'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
        followers,
        following,
        badge,
        community,
      ];
}
