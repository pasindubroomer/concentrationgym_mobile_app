part of 'bio_cubit.dart';

class BioState extends Equatable {
  final UserBioModel? userBioModel;
  final ProcessingStatus processingState;
  final SubmissionStatus submissionState;

  const BioState(
      {this.submissionState = SubmissionStatus.valueChanged,
      this.userBioModel = const UserBioModel(uid: " "),
      this.processingState = ProcessingStatus.loading});

  BioState copyWith({
    UserBioModel? userBioModel,
    ProcessingStatus? processingState,
    SubmissionStatus? submissionState,
  }) {
    return BioState(
      userBioModel: userBioModel ?? this.userBioModel,
      processingState: processingState ?? this.processingState,
      submissionState: submissionState ?? this.submissionState,
    );
  }

  @override
  List<Object?> get props => [userBioModel, processingState, submissionState];
}
