import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../shared/global/app_colors.dart';
import '../../shared/utils/app_values.dart';

Widget buildShimmerEffect(context) {
  return Scaffold(
    backgroundColor: AppColors.background,
    appBar: AppBar(
      title: const Text(
        'Logo',
        style: TextStyle(
            color: AppColors.dark, fontSize: 30, fontWeight: FontWeight.bold),
      ),
      bottom:PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Column(
          crossAxisAlignment:   CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('My tasks', style: TextStyle(color: AppColors.boldGrey, fontSize: 22)),
            ),
            SizedBox(height: mediaQueryHeight(context) * 0.01),
          ],
        ),
      )
    ),
    body: buildShimmerList(context),
  );
}

Widget buildShimmerList(context) {
  return ListView.builder(
    itemCount: 6,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(color: AppColors.primary),
            ),
            height: 100,
          ),
        ),
      );
    },
  );
}