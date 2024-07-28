import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../shared/components/toast_component.dart';
import '../../shared/global/app_colors.dart';
import '../../shared/utils/app_assets.dart';
import '../../shared/utils/app_values.dart';

Widget taskDetailsWidget(context, String formattedDate) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.primaryback,
    ),
    width: mediaQueryWidth(context),
    height: mediaQueryHeight(context) * .055,
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'End Date',
                style: TextStyle(fontSize: 10, color: AppColors.boldGrey),
              ),
              Text(
                formattedDate,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Image(
            image: AssetImage(ImageAssets.calendar),
            width: 28,
          ),
        ),
      ],
    ),
  );
}

Widget taskDetailsOneTextWidget(context, String text) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.primaryback,
    ),
    width: mediaQueryWidth(context),
    height: mediaQueryHeight(context) * .055,
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Image(
            image: AssetImage(ImageAssets.arrowDown),
            width: 28,
          ),
        ),
      ],
    ),
  );
}

Widget taskDetailsOneFlagWidget(
  context,
  String text,
) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.primaryback,
    ),
    width: mediaQueryWidth(context),
    height: mediaQueryHeight(context) * .055,
    child: Row(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Image(
            image: AssetImage(ImageAssets.flag),
            width: 24,
          ),
        ),
        Text(
          '$text Priority',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Image(
            image: AssetImage(ImageAssets.arrowDown),
            width: 28,
          ),
        ),
      ],
    ),
  );
}

Widget profileWidget(context, String text, String textHeader) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.backgroundGrey,
    ),
    width: mediaQueryWidth(context),
    height: mediaQueryHeight(context) * .08,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(textHeader),
          Text(
            '$text ',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.boldGrey,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget profileCopyWidget(context, String text, String textHeader) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.backgroundGrey,
    ),
    width: mediaQueryWidth(context),
    height: mediaQueryHeight(context) * .08,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(textHeader),
              Text(
                '$text ',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.boldGrey,
                ),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: text));

                showToast(
                    text: 'Copied to clipboard $text',
                    state: ToastStates.SUCCESS);
              },
              child: Image.asset(
                ImageAssets.copy,
                width: 24,
              )),
        ],
      ),
    ),
  );
}
