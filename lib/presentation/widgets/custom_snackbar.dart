import 'package:concentrationgym_mobile_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

SnackBar showSnackbar(String msg) {
  return SnackBar(
    elevation: 6.0,
    backgroundColor: kDefaultBlackColor,
    behavior: SnackBarBehavior.floating,
    content: Text(
      msg,
      style: TextStyle(color: kTextWhiteColor),
    ),
  );
}
