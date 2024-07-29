import 'package:flutter/material.dart';
import 'package:todo/shared/utils/app_strings.dart';
import 'package:todo/shared/utils/navigation.dart';

import '../../../shared/global/app_colors.dart';
import '../../../shared/utils/app_assets.dart';
import '../../../shared/utils/app_routes.dart';
import '../../../shared/utils/app_values.dart';

class BoardingScreen extends StatelessWidget {
  const BoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Image.asset(ImageAssets.login, fit: BoxFit.fill),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: mediaQueryHeight(context) * 0.6),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                 AppStrings.taskManagement,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  AppStrings.toDoList,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: mediaQueryHeight(context) * 0.05),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  AppStrings.thisProductive,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  AppStrings.youBetterManage,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  AppStrings.projectWiseConveniently,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
              SizedBox(height: mediaQueryHeight(context) * 0.04),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    navigateTo(
                        context: context, screenRoute: Routes.loginScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: AppColors.primary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.letsStart,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const Image(
                        image: AssetImage(
                          ImageAssets.icon,
                        ),
                        height: 30,
                        width: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
