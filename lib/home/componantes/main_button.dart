import 'package:flutter/material.dart';

import '../../shared/global/app_colors.dart';
import '../../shared/utils/app_values.dart';

class MainButton extends StatelessWidget {
  MainButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  final String title;
  final Function onPressed;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: AppSize.s230,
        height: AppSize.s45,
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppPadding.p50),
          ),
          onPressed: () => onPressed(),
          color: color ?? AppColors.primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_upload_rounded,color: AppColors.offWhite,),
              const SizedBox(
                width: 10,
              ),
              Text(title, style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
        ));
  }
}
