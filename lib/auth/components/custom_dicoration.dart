
import 'package:flutter/material.dart';

import '../../shared/global/app_colors.dart';

InputDecoration customInputDecoration({
  required String labelText,
  Widget? suffixIcon,
  required BuildContext context,
  bool alignLabelWithHint = false,

}) {
  return InputDecoration(
    alignLabelWithHint:   alignLabelWithHint,
    contentPadding: const EdgeInsets.symmetric(
        vertical: 12.0, horizontal: 16.0),
    labelText: labelText,
    labelStyle: Theme.of(context).textTheme.titleSmall,
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(color: AppColors.boldGrey),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(color: AppColors.boldGrey),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(color: AppColors.boldGrey),
    ),
    suffixIcon: suffixIcon,
  );
}
InputDecoration inputDecoration(String labelText,
    {IconData? suffixIcon, Color? color,bool alignLabelWithHint = false}) {
  return InputDecoration(
    suffix: suffixIcon != null
        ? Icon(
      suffixIcon,
      color: color,
    )
        : null,
    labelText: labelText,
    alignLabelWithHint:   alignLabelWithHint,
    contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: AppColors.backgroundLight),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: AppColors.backgroundLight),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(color: AppColors.  primary),
    ),
  );
}