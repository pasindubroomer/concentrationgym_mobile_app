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

  void goalieCareerTargetsChanged(String value) {
    emit(state.copyWith(
        userBioModel:
            state.userBioModel!.copyWith(goalieCareerTargets: value)));
  }

  void otherChanged(String value) {
    emit(state.copyWith(
        userBioModel: state.userBioModel!.copyWith(other: value)));
  }
}
