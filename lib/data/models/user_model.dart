import 'dart:convert';

class UserModel {
  final String? uid;
  final bool? isVerified;
  final String? email;
  final String? password;
  final String? displayName;
  final int? age;
  const UserModel({
    this.uid,
    this.isVerified,
    this.email,
    this.password,
    this.displayName,
    this.age,
  });

  UserModel copyWith({
    String? uid,
    bool? isVerified,
    String? email,
    String? password,
    String? displayName,
    int? age,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      isVerified: isVerified ?? this.isVerified,
      email: email ?? this.email,
      password: password ?? this.password,
      displayName: displayName ?? this.displayName,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (uid != null) {
      result.addAll({'uid': uid});
    }
    if (isVerified != null) {
      result.addAll({'isVerified': isVerified});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (password != null) {
      result.addAll({'password': password});
    }
    if (displayName != null) {
      result.addAll({'displayName': displayName});
    }
    if (age != null) {
      result.addAll({'age': age});
    }

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      isVerified: map['isVerified'],
      email: map['email'],
      password: map['password'],
      displayName: map['displayName'],
      age: map['age']?.toInt(),
    );
  }

  static const empty = UserModel(uid: "");

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(uid: $uid, isVerified: $isVerified, email: $email, password: $password, displayName: $displayName, age: $age)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.uid == uid &&
        other.isVerified == isVerified &&
        other.email == email &&
        other.password == password &&
        other.displayName == displayName &&
        other.age == age;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        isVerified.hashCode ^
        email.hashCode ^
        password.hashCode ^
        displayName.hashCode ^
        age.hashCode;
  }

  bool get isNotEmpty => this != UserModel.empty;
}
