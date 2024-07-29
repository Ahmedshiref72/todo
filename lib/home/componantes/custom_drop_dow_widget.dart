
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:todo/shared/global/app_colors.dart';
import 'package:todo/shared/utils/app_values.dart';

import '../../shared/utils/app_assets.dart';
class CustomDropdown extends StatelessWidget {
  final TextEditingController priorityController;

  CustomDropdown({required this.priorityController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:   mediaQueryHeight(context) * 0.08,
      child: DropdownButtonFormField<String>(
        value: 'medium',
        icon: const Image(
          image: AssetImage(ImageAssets.arrowDown),
          color: AppColors.primary,
          width: 25,
          height: 25,
        ),
        dropdownColor: AppColors.primaryback,
        style: const TextStyle(color: AppColors.boldGrey),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          filled: true,
          fillColor: AppColors.primaryback, // Adjust this to match your design
        ),
        items: [
          DropdownMenuItem<String>(
            value: 'low',
            child: Row(
              children: [
                Image(
                  image: AssetImage(ImageAssets.flag),
                  color: AppColors.primary,
                  width: 20,
                  height: 20,
                ),
                SizedBox(width: mediaQueryWidth(context) * .02),
                Text(
                  'Low Priority',
                  style: Theme.of(context ).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          DropdownMenuItem<String>(
            value: 'medium',
            child: Row(
              children: [
                Image(
                  image: AssetImage(ImageAssets.flag),
                  color: AppColors.primary,
                  width: 20,
                  height: 20,
                ),
                SizedBox(width: mediaQueryWidth(context) * .02),
                Text(
                  'Medium Priority',
                  style: Theme.of(context ).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          DropdownMenuItem<String>(
            value: 'high',
            child: Row(
              children: [
                Image(
                  image: AssetImage(ImageAssets.flag),
                  color: AppColors.primary,
                  width: 20,
                  height: 20,
                ),
                SizedBox(width: mediaQueryWidth(context) * .02),
                Text(
                  'High Priority',
                  style: Theme.of(context ).textTheme.titleMedium,
                ),
              ],
            ),
          ),

        ],
        onChanged: (value) {
          priorityController.text = value!;
        },
      ),
    );
  }
}
