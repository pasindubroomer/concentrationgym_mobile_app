part of 'profile_daily_status_cubit.dart';

class UserStatusState {
  final UserStatusModel? userDailyStatusModel;
  final ProcessingStatus processingState;
  final List<bool> toggleButtonSelectionList;
  final int toggleButtonSelectedIndex;
  final String? errorMessage;

  const UserStatusState(
      {this.userDailyStatusModel =
          const UserStatusModel(dailyEveningRouting: 0),
      this.errorMessage,
      this.processingState = ProcessingStatus.loading,
      this.toggleButtonSelectionList = const [true, false],
      this.toggleButtonSelectedIndex = 0});

  List<Object?> get props =>
      [userDailyStatusModel, processingState, toggleButtonSelectionList];

  UserStatusState copyWith(
      {UserStatusModel? userDailyStatusModel,
      ProcessingStatus? processingState,
      List<bool>? toggleButtonSelectionList,
      int? toggleButtonSelectedIndex,
      String? errorMessage}) {
    return UserStatusState(
      userDailyStatusModel: userDailyStatusModel ?? this.userDailyStatusModel,
      processingState: processingState ?? this.processingState,
      errorMessage: errorMessage ?? this.errorMessage,
      toggleButtonSelectionList:
          toggleButtonSelectionList ?? this.toggleButtonSelectionList,
      toggleButtonSelectedIndex:
          toggleButtonSelectedIndex ?? this.toggleButtonSelectedIndex,
    );
  }
}
