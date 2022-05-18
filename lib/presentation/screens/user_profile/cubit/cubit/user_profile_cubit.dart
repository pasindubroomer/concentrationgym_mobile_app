import 'package:bloc/bloc.dart';
import 'package:concentrationgym_mobile_app/core/exceptions/failure.dart';
import 'package:concentrationgym_mobile_app/data/models/user_daily_status_model.dart';
import 'package:concentrationgym_mobile_app/data/repositories/common_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/enums.dart';
import '../../../../../data/models/user_profile_model.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final CommonRepository _commonRepository;

  UserProfileCubit(this._commonRepository) : super(const UserProfileState());

  Future<void> getUserData() async {
    emit(state.copyWith(loadingState: ProcessingStatus.loading));
    try {
      final userData =
          await _commonRepository.getUserProfileDetails("aipHwEhw9U1xqqQGU8oE");
      final userDailyStatusData =
      await _commonRepository.getUserDailyStatus("aipHwEhw9U1xqqQGU8oE");
      emit(state.copyWith(userProfileModel: userData,userDailyStatusModel: userDailyStatusData, loadingState: ProcessingStatus.success));
    } on Exception catch (e) {
      emit(state.copyWith(loadingState: ProcessingStatus.exception,errorMessage: e.toString()));
    }
  }

  void toggleButtonChanged(int index) {
    emit(state.copyWith(loadingState: ProcessingStatus.loading));
    final List<bool> _list = [false, false];
    _list[index] = true;
    emit(state.copyWith(
        toggleButtonSelectionList: _list,
        toggleButtonSelectedIndex: index,
        loadingState: ProcessingStatus.success));
  }
}
