import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/constants/colors.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  const AppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Bio",
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      elevation: 1,
      centerTitle: true,
      leading: const Icon(Icons.alarm),
      actions: [
        const Icon(
          Icons.settings,
          size: 30,
        ),
        SizedBox(
          width: 2.w,
        )
      ],
      iconTheme: IconThemeData(
        color: kTextBlackColor, //change your color here
      ),
      backgroundColor: kmainBackgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}