part of 'bio_cubit.dart';

class BioState extends Equatable {
  final UserBioModel? userBioModel;
  final ProcessingStatus processingState;

  const BioState(
      {this.userBioModel = const UserBioModel(uid: " "),
      this.processingState = ProcessingStatus.loading});

  BioState copyWith({
    UserBioModel? userBioModel,
    ProcessingStatus? processingState,
  }) {
    return BioState(
      userBioModel: userBioModel ?? this.userBioModel,
      processingState: processingState ?? this.processingState,
    );
  }

  @override
  List<Object?> get props => [userBioModel, processingState];
}
