import 'package:todo/shared/global/app_colors.dart';
import 'package:todo/shared/global/app_theme.dart';
import 'package:todo/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';
import '../utils/app_values.dart';

class AlertDialogResult extends StatelessWidget {
  const AlertDialogResult({
    required this.imageSrc,
    required this.text,
    required this.text2,
    Key? key}) : super(key: key);
  final String imageSrc;
  final String text;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppPadding.p28),
        ),
        elevation: 50.0,
        content: SizedBox(
          height: mediaQueryHeight(context)*.45,
          width: mediaQueryWidth(context)*.9,
          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: mediaQueryHeight(context) / AppSize.s7,
              ),
             const Divider(

            thickness: 8, color: AppColors.lightGreen,


             ),
              SizedBox(
                  height: mediaQueryHeight(context) / AppSize.s50,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(text,
                  style:  lightTheme.textTheme.titleSmall
                ),
              ),
              SizedBox(
                height: mediaQueryHeight(context) / AppSize.s50,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(text2,
                  style: lightTheme.textTheme.titleMedium
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  TextButton(onPressed: (){Navigator.pop(context);},
                      child:  Text(
                        AppStrings.cancel,
                        style: lightTheme.textTheme.headlineLarge
                      ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}