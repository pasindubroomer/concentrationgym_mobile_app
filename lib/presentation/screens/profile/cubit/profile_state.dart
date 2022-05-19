part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final UserProfileModel? userProfileModel;
  final UserStatusModel? userDailyStatusModel;
  final ProcessingStatus mainProcessingState;
  final ProcessingStatus dailyDataProcessingState;
  final List<bool> toggleButtonSelectionList;
  final int toggleButtonSelectedIndex;
  final String? errorMessage;

  const ProfileState(
      {this.userProfileModel = const UserProfileModel(email: " "),
      this.userDailyStatusModel = const UserStatusModel(dailyEveningRouting: 0),
      this.errorMessage,
      this.mainProcessingState = ProcessingStatus.loading,
      this.dailyDataProcessingState = ProcessingStatus.loading,
      this.toggleButtonSelectionList = const [true, false],
      this.toggleButtonSelectedIndex = 0});

  @override
  List<Object?> get props => [
        userProfileModel,
        userProfileModel,
        mainProcessingState,
        toggleButtonSelectionList,
        dailyDataProcessingState
      ];

  ProfileState copyWith(
      {UserProfileModel? userProfileModel,
      UserStatusModel? userDailyStatusModel,
      ProcessingStatus? mainProcessingState,
      ProcessingStatus? dailyDataProcessingState,
      List<bool>? toggleButtonSelectionList,
      int? toggleButtonSelectedIndex,
      String? errorMessage}) {
    return ProfileState(
      userProfileModel: userProfileModel ?? this.userProfileModel,
      userDailyStatusModel: userDailyStatusModel ?? this.userDailyStatusModel,
      mainProcessingState: mainProcessingState ?? this.mainProcessingState,
      dailyDataProcessingState:
          mainProcessingState ?? this.dailyDataProcessingState,
      errorMessage: errorMessage ?? this.errorMessage,
      toggleButtonSelectionList:
          toggleButtonSelectionList ?? this.toggleButtonSelectionList,
      toggleButtonSelectedIndex:
          toggleButtonSelectedIndex ?? this.toggleButtonSelectedIndex,
    );
  }
}
