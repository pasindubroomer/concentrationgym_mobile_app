import 'package:cloud_firestore/cloud_firestore.dart';
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

  final CollectionReference userRoutingSessionHistory =
      FirebaseFirestore.instance.collection('user_routing_session_history');

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

  Future<List<UserRoutingSessionHistoryModel>> getUserRoutingSessionHistory(
      String uid) async {
    try {
      final ref = userRoutingSessionHistory.doc(uid).collection("sessions");
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
