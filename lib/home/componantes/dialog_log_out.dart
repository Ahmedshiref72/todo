import 'package:flutter/material.dart';
import '../../shared/global/app_colors.dart';
import '../../shared/utils/app_strings.dart';

Future<bool?> showLogoutConfirmationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.primaryback,
      title: Text(
        AppStrings.confirmLogout,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Text(
        AppStrings.logoutConfirmation,
        style: const TextStyle(color: AppColors.boldGrey),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(
            AppStrings.cancel,
            style: TextStyle(color: AppColors.boldGrey),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            AppStrings.logout,
            style: const TextStyle(color: AppColors.red),
          ),
        ),
      ],
    ),
  );
}
