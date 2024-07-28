import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/utils/app_values.dart';

import '../../../shared/global/app_colors.dart';
import '../../../shared/utils/app_assets.dart';
import '../../componantes/contanier_widget.dart';
import '../controller/home_controller/home_cubit.dart';
import '../controller/profile/profile_cubit.dart';
import '../controller/profile/profile_states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
          leadingWidth: 30,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                context.read<HomeCubit>().fetchTasks();
              },
              child: Image.asset(
                ImageAssets.arrowBack,
                color: AppColors.dark,
              )),
          title: const Text('Profile',
              style: TextStyle(
                  color: AppColors.dark,
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
      body: BlocProvider(
        create: (_) => ProfileCubit()..fetchProfile(),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              final profile = state.profile;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    profileWidget(context, profile.displayName, "NAME"),
                    SizedBox(
                      height: mediaQueryHeight(context) * .01,
                    ),
                    profileCopyWidget(context, profile.username, "PHONE"),
                    SizedBox(
                      height: mediaQueryHeight(context) * .01,
                    ),
                    profileWidget(context, profile.level, "LEVEL"),
                    SizedBox(
                      height: mediaQueryHeight(context) * .01,
                    ),
                    profileWidget(context, '${profile.experienceYears}  years',
                        "YEARS OF EXPERIENCE"),
                    SizedBox(
                      height: mediaQueryHeight(context) * .01,
                    ),
                    profileWidget(context, profile.address, "LOCATION"),
                  ],
                ),
              );
            } else if (state is ProfileError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
