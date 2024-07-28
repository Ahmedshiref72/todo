import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../shared/utils/app_values.dart';

Widget buildShimmerOneTaskEffect(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: double.infinity,
            height: mediaQueryHeight(context) * .2,
            decoration:   BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
         SizedBox(height: mediaQueryHeight(context) * .08),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: double.infinity,
            decoration:   BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            height: mediaQueryHeight(context) * .1,
          ),
        ),
        SizedBox(height: mediaQueryHeight(context) * .04),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: double.infinity,
            decoration:   BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            height: mediaQueryHeight(context) * .1,
          ),
        ),
        SizedBox(height: mediaQueryHeight(context) * .04),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: double.infinity,
            decoration:   BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            height: mediaQueryHeight(context) * .1,
          ),
        ),
        SizedBox(height: mediaQueryHeight(context) * .04),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: double.infinity,
            decoration:   BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            height: mediaQueryHeight(context) * .1,
          ),
        ),
      ],
    ),
  );
}
