import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserProfileModel extends Equatable {
  final String? uid;
  final String? name;
  final String? email;
  final int? followers;
  final int? following;
  final String? badge;
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
