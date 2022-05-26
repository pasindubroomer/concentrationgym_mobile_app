import 'package:concentrationgym_mobile_app/data/models/challenge_model.dart';
import 'package:concentrationgym_mobile_app/data/models/user_profile_model.dart';
import 'package:hive/hive.dart';

import '../models/user_routing_session_history_model.dart';

class LocalDataRepository {
  Future<void> addUserProfileDetails(UserProfileModel userProfileModel) async {
    var box = await Hive.openBox('userProfileBox');
    box.put('userProfile', userProfileModel);
  }

  Future<UserProfileModel?> getUserProfileDetails() async {
    var box = await Hive.openBox('userProfileBox');
    return box.get('userProfile');
  }

  Future<void> addUserRoutingSessionHistory(
      List<UserRoutingSessionHistoryModel>
          userRoutingSessionHistoryModelList) async {
    var box = await Hive.openBox('userRoutingSessionHistoryBox');
    box.put('historyList', userRoutingSessionHistoryModelList);
  }

  Future<List<UserRoutingSessionHistoryModel>?>
      getUserRoutingSessionHistory() async {
    var box = await Hive.openBox('userRoutingSessionHistoryBox');
    var historyList = box.get('historyList');
    if (historyList != null) {
      return (historyList as List)
          .map((e) => e as UserRoutingSessionHistoryModel)
          .toList();
    }

    return null;
  }

  Future<void> addChallenge(List<ChallengeModel> challengeModelList) async {
    var box = await Hive.openBox('challengeBox');
    box.put('challengeList', challengeModelList);
  }

  Future<List<ChallengeModel>?> getChallenge() async {
    var box = await Hive.openBox('challengeBox');
    var challengeList = box.get('challengeList');
    if (challengeList != null) {
      return (challengeList as List).map((e) => e as ChallengeModel).toList();
    }

    return null;
  }
}
