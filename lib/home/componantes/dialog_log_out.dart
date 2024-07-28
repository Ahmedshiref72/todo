import 'package:flutter/material.dart';

import '../../shared/global/app_colors.dart';

Future<bool?> showLogoutConfirmationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.primaryback,
      title: Text(
        'Confirm Logout',
        style: TextStyle(
            color: AppColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      content: Text(
        'Are you sure you want to log out?',
        style: TextStyle(color: AppColors.boldGrey),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'Cancel',
            style: TextStyle(color: AppColors.boldGrey),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            'Logout',
            style: TextStyle(color: AppColors.red),
          ),
        ),
      ],
    ),
  );
}
