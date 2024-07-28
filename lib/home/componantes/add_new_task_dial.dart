import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:todo/shared/global/app_colors.dart';

FloatingActionButton buildDialQr(BuildContext context,Function()? onTap) {
 return FloatingActionButton(
    heroTag:  'qr',
   backgroundColor: AppColors.primaryback,
    shape:  RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0),
    ),
    onPressed: onTap,
    child: Icon(Icons.qr_code_scanner, color:AppColors.primary),

  );
}

FloatingActionButton buildDialAdd(BuildContext context,Function()? onTap) {
  return FloatingActionButton(
    heroTag:  'add',
    backgroundColor: AppColors.primary,
    shape:  RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0),
    ),
    onPressed: onTap,
    child: Icon(Icons.add, color: Colors.white),

  );
}

