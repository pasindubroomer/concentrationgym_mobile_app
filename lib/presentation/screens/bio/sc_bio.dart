import 'package:concentrationgym_mobile_app/presentation/screens/bio/cubit/cubit/bio_cubit.dart';
import 'package:concentrationgym_mobile_app/presentation/widgets/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/default_size.dart';
import '../../../core/constants/enums.dart';
import '../../../data/repositories/common_repository.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/custom_snackbar.dart';

class BioScreen extends StatefulWidget {
  const BioScreen({Key? key}) : super(key: key);

  @override
  State<BioScreen> createState() => _BioScreenState();
}

class _BioScreenState extends State<BioScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<BioCubit>(
            create: (BuildContext context) =>
                BioCubit(context.read<CommonRepository>())..getUserBioDetails(),
          ),
        ],
        child: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  toolbarHeight: 5.h,
                  iconTheme: const IconThemeData(
                    color: Colors.black, //change your color here
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: kPaddingDefault,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocListener<BioCubit, BioState>(
                          listener: (context, state) {
                            if (state.submissionState ==
                                SubmissionStatus.success) {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  showSnackbar("Updated successfully"),
                                );
                            }
                            if (state.processingState ==
                                ProcessingStatus.exception) {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  showSnackbar("Error occured"),
                                );
                            }
                            if (state.processingState ==
                                ProcessingStatus.error) {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  showSnackbar("Error occured"),
                                );
                            }
                          },
                          child: BlocBuilder<BioCubit, BioState>(
                            builder: (context, state) {
                              return _buildBioContent(context, state);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ))));
  }

  Widget _buildBioContent(BuildContext context, BioState state) {
    if (state.processingState == ProcessingStatus.success) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(
            height: 4.h,
          ),
          _buildTeam(context, state),
          SizedBox(
            height: 2.h,
          ),
          _buildLeague(context, state),
          SizedBox(
            height: 2.h,
          ),
          _buildFavouriteGoalie(context, state),
          SizedBox(
            height: 2.h,
          ),
          _buildCareerTargets(context, state),
          SizedBox(
            height: 2.h,
          ),
          _buildOther(context, state),
          SizedBox(
            height: 2.h,
          ),
          _buildSubmitButton(context)
        ],
      );
    } else if (state.processingState == ProcessingStatus.loading) {
      return const LoadingFull();
    } else if (state.processingState == ProcessingStatus.error) {
      return const Center(
        child: Text('Cannot load data'),
      );
    } else {
      return const Center(
        child: Text('Unknown state'),
      );
    }
  }

  Text _buildHeader(BuildContext context) {
    return Text(
      "Tell us about yourself",
      style: Theme.of(context)
          .textTheme
          .headline4!
          .copyWith(color: kTextBlackColor),
    );
  }

  GestureDetector _buildSubmitButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<BioCubit>().updateUserBioDetails(),
      child: Container(
        width: 100.w,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: kDefaultBlueColor),
        child: Text(
          "SUBMIT",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontSize: 15, color: kTextWhiteColor),
        ),
      ),
    );
  }

  Widget _buildTeam(BuildContext context, BioState state) {
    return BlocBuilder<BioCubit, BioState>(
      buildWhen: (previous, current) =>
          previous.processingState != current.processingState,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.userBioModel!.team ?? " ",
          onChanged: (team) => context.read<BioCubit>().teamChanged(team),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
            labelText: 'Team',
            border: const OutlineInputBorder(),
          ),
          maxLines: 5, // <-- SEE HERE
          minLines: 1, // <-- SEE HERE
        );
      },
    );
  }

  Widget _buildLeague(BuildContext context, BioState state) {
    return BlocBuilder<BioCubit, BioState>(
      buildWhen: (previous, current) =>
          previous.userBioModel!.league != current.userBioModel!.league,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.userBioModel!.league ?? " ",
          onChanged: (league) => context.read<BioCubit>().leagueChanged(league),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
            labelText: 'League',
            border: const OutlineInputBorder(),
          ),
          maxLines: 5, // <-- SEE HERE
          minLines: 1, // <-- SEE HERE
        );
      },
    );
  }

  Widget _buildFavouriteGoalie(BuildContext context, BioState state) {
    return BlocBuilder<BioCubit, BioState>(
      buildWhen: (previous, current) =>
          previous.userBioModel!.favouriteGoalie !=
          current.userBioModel!.favouriteGoalie,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.userBioModel!.favouriteGoalie ?? " ",
          onChanged: (favouriteGoalie) =>
              context.read<BioCubit>().favouriteGoalieChanged(favouriteGoalie),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
            labelText: 'Favourite Goalie',
            border: const OutlineInputBorder(),
          ),
          maxLines: 5, // <-- SEE HERE
          minLines: 1, // <-- SEE HERE
        );
      },
    );
  }

  Widget _buildCareerTargets(BuildContext context, BioState state) {
    return BlocBuilder<BioCubit, BioState>(
      buildWhen: (previous, current) =>
          previous.userBioModel!.careerTargets !=
          current.userBioModel!.careerTargets,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.userBioModel!.careerTargets ?? " ",
          onChanged: (careerTargets) =>
              context.read<BioCubit>().careerTargetsChanged(careerTargets),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
            labelText: 'Goalie Career Targets',
            border: const OutlineInputBorder(),
          ),
          maxLines: 5, // <-- SEE HERE
          minLines: 1, // <-- SEE HERE
        );
      },
    );
  }

  Widget _buildOther(BuildContext context, BioState state) {
    return BlocBuilder<BioCubit, BioState>(
      buildWhen: (previous, current) =>
          previous.userBioModel!.other != current.userBioModel!.other,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.userBioModel!.other ?? " ",
          onChanged: (other) => context.read<BioCubit>().otherChanged(other),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
            labelText: 'Other',
            border: const OutlineInputBorder(),
          ),
          maxLines: 5, // <-- SEE HERE
          minLines: 1, // <-- SEE HERE
        );
      },
    );
  }
}
