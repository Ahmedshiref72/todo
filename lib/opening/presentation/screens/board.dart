import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                  'Task Management &',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: AppColors.dark,
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'To-Do List',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: AppColors.dark,
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                ),
              ),
              SizedBox(height: mediaQueryHeight(context) * 0.05),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'This productive tool is designed to help',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: AppColors.boldGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'you better manage your task ',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: AppColors.boldGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'project-wise conveniently!',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: AppColors.boldGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
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
                    padding: EdgeInsets.symmetric(vertical: 16),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: AppColors.primary,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Let’s Start',
                          style: TextStyle(
                              color: AppColors.offWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Image(
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
