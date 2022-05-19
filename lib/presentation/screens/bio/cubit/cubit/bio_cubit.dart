import 'package:bloc/bloc.dart';
import 'package:concentrationgym_mobile_app/data/models/user_bio_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/enums.dart';
import '../../../../../data/repositories/common_repository.dart';

part 'bio_state.dart';

class BioCubit extends Cubit<BioState> {
  final CommonRepository _commonRepository;
  BioCubit(this._commonRepository) : super(const BioState());

  void teamChanged(String value) {
    emit(state.copyWith(
        userBioModel: state.userBioModel!.copyWith(team: value)));
  }

  void leagueChanged(String value) {
    emit(state.copyWith(
        userBioModel: state.userBioModel!.copyWith(league: value)));
  }

  void favouriteGoalieChanged(String value) {
    emit(state.copyWith(
        userBioModel: state.userBioModel!.copyWith(favouriteGoalie: value)));
  }

  void careerTargetsChanged(String value) {
    emit(state.copyWith(
        userBioModel: state.userBioModel!.copyWith(careerTargets: value)));
  }

  void otherChanged(String value) {
    print(value);
    emit(state.copyWith(
        userBioModel: state.userBioModel!.copyWith(other: value)));
  }

  Future<void> getUserBioDetails() async {
    emit(state.copyWith(processingState: ProcessingStatus.loading));
    try {
      final userBioData =
          await _commonRepository.getUserBioDetails("aipHwEhw9U1xqqQGU8oE");
      emit(state.copyWith(
          userBioModel: userBioData,
          processingState: ProcessingStatus.success));
    } on Exception catch (_) {
      emit(state.copyWith(processingState: ProcessingStatus.exception));
    }
  }

  Future<void> updateUserBioDetails() async {
    emit(state.copyWith(processingState: ProcessingStatus.loading));
    try {
      await _commonRepository.updateUserBioDetails(
          "aipHwEhw9U1xqqQGU8oE", state.userBioModel!);
      emit(state.copyWith(processingState: ProcessingStatus.submissionSuccess));
    } on Exception catch (_) {
      emit(state.copyWith(processingState: ProcessingStatus.exception));
    }
  }
}
