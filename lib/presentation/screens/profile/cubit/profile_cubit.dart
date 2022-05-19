import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums.dart';
import '../../../../data/models/user_daily_status_model.dart';
import '../../../../data/models/user_profile_model.dart';
import '../../../../data/repositories/common_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final CommonRepository _commonRepository;

  ProfileCubit(this._commonRepository) : super(const ProfileState());

  Future<void> getUserPersonalDetails() async {
    emit(state.copyWith(mainProcessingState: ProcessingStatus.loading));
    try {
      final userData =
          await _commonRepository.getUserProfileDetails("aipHwEhw9U1xqqQGU8oE");

      emit(state.copyWith(
          userProfileModel: userData,
          mainProcessingState: ProcessingStatus.success));
    } on Exception catch (e) {
      emit(state.copyWith(
          mainProcessingState: ProcessingStatus.exception,
          errorMessage: e.toString()));
    }
  }
}
