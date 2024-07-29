import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:todo/shared/components/toast_component.dart';
import 'package:todo/shared/utils/app_assets.dart';
import 'package:todo/shared/utils/app_strings.dart';
import 'package:todo/shared/utils/app_values.dart';
import 'package:todo/shared/utils/navigation.dart';
import '../../../shared/global/app_colors.dart';
import '../../../shared/utils/app_routes.dart';
import '../../components/custom_dicoration.dart';
import '../controller/auth_cubit.dart';
import '../controller/auth_states.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _experienceYearsController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();

  String _phoneNumberStr = '';

  @override
  void dispose() {
    _passwordController.dispose();
    _displayNameController.dispose();
    _experienceYearsController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _levelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthRegisterSuccess) {
            showToast(text: AppStrings.registerSuccess, state: ToastStates.SUCCESS);
            navigateFinalTo(context: context, screenRoute: Routes.loginScreen);
          } else if (state is AuthRegisterError) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Image.asset(
                  ImageAssets.login,
                  height: mediaQueryHeight(context) * 0.4,
                  width: mediaQueryHeight(context),
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: mediaQueryHeight(context) * 0.28),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          AppStrings.signUpHere,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      SizedBox(height: mediaQueryHeight(context) * 0.02),
                      TextField(
                        controller: _displayNameController,
                        decoration: inputDecoration(AppStrings.signUpHere),
                      ),
                      SizedBox(height: mediaQueryHeight(context) * 0.02),
                      IntlPhoneField(
                        controller: _phoneNumberController,
                        decoration: inputDecoration(AppStrings.phoneNumber),
                        initialCountryCode: 'EG',
                        onChanged: (phone) {
                          _phoneNumberStr = phone.completeNumber;
                        },
                      ),
                      SizedBox(height: mediaQueryHeight(context) * 0.02),
                      TextField(
                        controller: _experienceYearsController,
                        keyboardType: TextInputType.number,
                        decoration: inputDecoration(AppStrings.youBetterManage),
                      ),
                      SizedBox(height: mediaQueryHeight(context) * 0.02),
                      DropdownButtonFormField<String>(
                        dropdownColor: AppColors.offWhite,
                        style: TextStyle(color: AppColors.boldGrey),
                        decoration: inputDecoration(AppStrings.letsStart),
                        items: [
                          AppStrings.fresh,
                          AppStrings.junior,
                          AppStrings.midLevel,
                          AppStrings.senior
                        ].map((level) => DropdownMenuItem<String>(
                          value: level,
                          child: Text(level),
                        )).toList(),
                        onChanged: (value) {
                          _levelController.text = value!;
                        },
                      ),
                      SizedBox(height: mediaQueryHeight(context) * 0.02),
                      TextField(
                        controller: _addressController,
                        decoration: inputDecoration(AppStrings.address),
                      ),
                      SizedBox(height: mediaQueryHeight(context) * 0.02),
                      TextField(
                        controller: _passwordController,
                        obscureText: AuthCubit.get(context).isObsecured,
                        decoration: inputDecoration(AppStrings.password).copyWith(
                          suffixIcon: IconButton(
                            icon: AuthCubit.get(context).isObsecured
                                ? const Icon(
                              Icons.visibility_off_outlined,
                              color: AppColors.boldGrey,
                            )
                                : const Icon(
                              Icons.visibility_outlined,
                              color: AppColors.boldGrey,
                            ),
                            onPressed: () {
                              AuthCubit.get(context).changeVisibility();
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: mediaQueryHeight(context) * 0.02),
                      state is AuthRegisterLoading
                          ? Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AuthCubit>(context).register(
                            phone: _phoneNumberStr,
                            password: _passwordController.text,
                            displayName: _displayNameController.text,
                            experienceYears: int.tryParse(
                                _experienceYearsController.text) ?? 0,
                            address: _addressController.text,
                            level: _levelController.text,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          textStyle: TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          AppStrings.signUp,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                         navigateTo(context: context, screenRoute: Routes.loginScreen);
                        },
                        child: Text.rich(
                          TextSpan(
                            text: AppStrings.didnTHaveAccount,
                            style: Theme.of(context).textTheme.titleSmall,
                            children: [
                              TextSpan(
                                text: AppStrings.signIn,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                    decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}


