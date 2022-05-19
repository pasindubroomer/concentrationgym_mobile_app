import 'package:concentrationgym_mobile_app/presentation/screens/bio/cubit/cubit/bio_cubit.dart';
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
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: kPaddingDefault,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocListener<BioCubit, BioState>(
                          listener: (context, state) {
                            if (state.processingState ==
                                ProcessingStatus.submissionSuccess) {
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
    if (state.processingState == ProcessingStatus.success ||
        state.processingState == ProcessingStatus.submissionSuccess) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tell us about yourself",
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: kTextBlackColor),
          ),
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
          GestureDetector(
            onTap: () => context.read<BioCubit>().updateUserBioDetails(),
            child: Container(
              width: 100.w,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: kDefaultBlueColor),
              child: Text(
                "Update",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 15),
              ),
            ),
          )
        ],
      );
    } else if (state.processingState == ProcessingStatus.loading) {
      return Stack(
        children: [
          SizedBox(
            width: 100.w,
            height: 100.h,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      );
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
