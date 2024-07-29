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
              Text(formattedDate,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.dark,
                      )),
            ],
          ),
        ),
        const Spacer(),
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
          child: Text(text, style: Theme.of(context).textTheme.titleMedium),
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
            width: 22,
          ),
        ),
        Text('$text Priority', style: Theme.of(context).textTheme.titleMedium),
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
          SizedBox(height:  mediaQueryHeight(context) * .01,),
          Text(
            textHeader,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          SizedBox(height:  mediaQueryHeight(context) * .01,),
          Text(
            '$text ',
            style:Theme.of(context).textTheme.displayLarge,
          ),
        ],
      ),
    ),
  );
}
String formatPhoneNumber(String phoneNumber) {
  if (phoneNumber.length >= 12) {
    return '${phoneNumber.substring(0, 2)} ${phoneNumber.substring(2, 5)} ${phoneNumber.substring(5, 8)}-${phoneNumber.substring(8)}';
  } else {
    return phoneNumber; // return the phone number as is if it's not long enough
  }
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
              SizedBox(height:  mediaQueryHeight(context) * .01,),
              Text(
                textHeader,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height:  mediaQueryHeight(context) * .01,),
              Text(
                formatPhoneNumber(text),
                style:Theme.of(context).textTheme.displayLarge,
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
