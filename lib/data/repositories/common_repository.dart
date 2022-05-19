import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:concentrationgym_mobile_app/data/models/user_bio_model.dart';
import '../../core/exceptions/failure.dart';
import '../models/user_daily_status_model.dart';
import '../models/user_profile_model.dart';
import '../models/user_routing_session_history_model.dart';

class CommonRepository {
  final FirebaseFirestore _firestore;

  final CollectionReference userDetailsCollection =
      FirebaseFirestore.instance.collection('user_details');

  final CollectionReference userStatusCollection =
      FirebaseFirestore.instance.collection('user_daily_exercises');

  final CollectionReference userRoutingSessionHistoryCollection =
      FirebaseFirestore.instance.collection('user_routing_session_history');

  final CollectionReference userBioCollection =
      FirebaseFirestore.instance.collection('user_bio');

  CommonRepository({FirebaseFirestore? firebaseFirestore})
      : _firestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<UserProfileModel> getUserProfileDetails(String uid) async {
    try {
      final ref = userDetailsCollection.doc(uid).withConverter(
            fromFirestore: UserProfileModel.fromFirestore,
            toFirestore: (UserProfileModel user, _) => user.toFirestore(),
          );
      final docSnap = await ref.get();
      return docSnap.data() ?? UserProfileModel.empty;
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<UserStatusModel> getUserDailyStatus(String uid) async {
    try {
      final ref = userStatusCollection.doc(uid).withConverter(
            fromFirestore: UserStatusModel.fromFirestore,
            toFirestore: (UserStatusModel user, _) => user.toFirestore(),
          );
      final docSnap = await ref.get();
      return docSnap.data() ?? UserStatusModel.empty;
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<UserBioModel> getUserBioDetails(String uid) async {
    try {
      final ref = userBioCollection.doc(uid);
      final docSnap = await ref.get();

      if (docSnap.exists) {
        return UserBioModel.fromJson(docSnap.data()! as Map<String, dynamic>);
      } else {
        return UserBioModel.empty;
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> updateUserBioDetails(
      String uid, UserBioModel userBioModel) async {
    try {
      final ref = userBioCollection.doc(uid);
      await ref.update(userBioModel.toJson()).catchError((onError) {
        throw Failure(onError.toString());
      });
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<List<UserRoutingSessionHistoryModel>> getUserRoutingSessionHistory(
      String uid) async {
    try {
      final ref =
          userRoutingSessionHistoryCollection.doc(uid).collection("sessions");
      final docSnap = await ref.get();
      List<UserRoutingSessionHistoryModel> _userSessions = docSnap.docs
          .map((d) => UserRoutingSessionHistoryModel.fromJson(d.data()))
          .toList();
      return _userSessions;
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
