import 'package:concentrationgym_mobile_app/presentation/screens/bio/cubit/cubit/bio_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/default_size.dart';
import '../../../data/repositories/common_repository.dart';
import '../../widgets/app_bar.dart';

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
                BioCubit(context.read<CommonRepository>()),
          ),
        ],
        child: SafeArea(
            child: Scaffold(
                appBar: const AppBarWidget(),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: kPaddingDefault,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder<BioCubit, BioState>(
                          builder: (context, state) {
                            return _buildBioContent(context, state);
                          },
                        ),
                      ],
                    ),
                  ),
                ))));
  }

  Widget _buildBioContent(BuildContext context, BioState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "TELL US ABOUT YOURSELF",
          style: Theme.of(context).textTheme.headline6,
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
        _buildGoalieCareerTargets(context, state),
        SizedBox(
          height: 2.h,
        ),
        _buildOther(context, state),
      ],
    );
  }

  Widget _buildTeam(BuildContext context, BioState state) {
    return BlocBuilder<BioCubit, BioState>(
      buildWhen: (previous, current) =>
          previous.userBioModel!.team != current.userBioModel!.team,
      builder: (context, state) {
        return TextField(
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
          previous.userBioModel!.team != current.userBioModel!.team,
      builder: (context, state) {
        return TextField(
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
          previous.userBioModel!.team != current.userBioModel!.team,
      builder: (context, state) {
        return TextField(
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

  Widget _buildGoalieCareerTargets(BuildContext context, BioState state) {
    return BlocBuilder<BioCubit, BioState>(
      buildWhen: (previous, current) =>
          previous.userBioModel!.team != current.userBioModel!.team,
      builder: (context, state) {
        return TextField(
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
          previous.userBioModel!.team != current.userBioModel!.team,
      builder: (context, state) {
        return TextField(
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
