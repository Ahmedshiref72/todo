import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:todo/shared/components/toast_component.dart';
import 'package:todo/shared/utils/app_assets.dart';
import 'package:todo/shared/utils/app_values.dart';
import 'package:todo/shared/utils/navigation.dart';
import '../../../shared/global/app_colors.dart';
import '../../../shared/utils/app_routes.dart';
import '../controller/auth_cubit.dart';
import '../controller/auth_states.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _experienceYearsController =
      TextEditingController();
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
            showToast(
                text: 'User created successfully', state: ToastStates.SUCCESS);
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
                child: Image.asset(ImageAssets.login,
                    height: mediaQueryHeight(context) * 0.4,
                    width: mediaQueryHeight(context),
                    fit: BoxFit.fitWidth),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: mediaQueryHeight(context) * 0.24),
                      Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      TextField(
                        controller: _displayNameController,
                        decoration: inputDecoration('Name'),
                      ),
                      SizedBox(height: mediaQueryHeight(context) * 0.02),
                      IntlPhoneField(
                        controller: _phoneNumberController,
                        decoration: inputDecoration('Phone Number'),
                        initialCountryCode: 'EG',
                        onChanged: (phone) {
                          _phoneNumberStr = phone.completeNumber;
                        },
                      ),
                      SizedBox(height: mediaQueryHeight(context) * 0.02),
                      TextField(
                        controller: _experienceYearsController,
                        keyboardType: TextInputType.number,
                        decoration: inputDecoration('Years of experience'),
                      ),
                      SizedBox(height: mediaQueryHeight(context) * 0.02),
                      DropdownButtonFormField<String>(
                        dropdownColor: AppColors.offWhite,
                        style: TextStyle(color: AppColors.boldGrey),
                        decoration: inputDecoration('Choose experience Level'),
                        items: ['fresh', 'junior', 'midLevel', 'senior']
                            .map((level) => DropdownMenuItem<String>(
                                  value: level,
                                  child: Text(level),
                                ))
                            .toList(),
                        onChanged: (value) {
                          _levelController.text = value!;
                        },
                      ),
                      SizedBox(height: mediaQueryHeight(context) * 0.02),
                      TextField(
                        controller: _addressController,
                        decoration: inputDecoration('Address'),
                      ),
                      SizedBox(height: mediaQueryHeight(context) * 0.02),
                      TextField(
                        controller: _passwordController,
                        obscureText: AuthCubit.get(context).isObsecured,
                        decoration: inputDecoration('Password').copyWith(
                          suffixIcon: IconButton(
                            icon: AuthCubit.get(context).isObsecured
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: AppColors.boldGrey,
                                  )
                                : const Icon(
                                    Icons.visibility,
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
                                          _experienceYearsController.text) ??
                                      0,
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
                              child: Text('Sign up',
                                  style: TextStyle(color: AppColors.offWhite)),
                            ),
                      TextButton(
                        onPressed: () {
                          // Navigate to the Sign-In screen
                        },
                        child: const Text.rich(
                          TextSpan(
                            text: 'Already have any account? ',
                            style: TextStyle(
                                color: AppColors.boldGrey, fontSize: 14),
                            children: [
                              TextSpan(
                                text: 'Sign in',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
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

InputDecoration inputDecoration(String labelText,
    {IconData? suffixIcon, Color? color,bool alignLabelWithHint = false}) {
  return InputDecoration(
    suffix: suffixIcon != null
        ? Icon(
            suffixIcon,
            color: color,
          )
        : null,
    labelText: labelText,
    alignLabelWithHint:   alignLabelWithHint,
    contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: AppColors.backgroundLight),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: AppColors.backgroundLight),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(color: AppColors.  primary),
    ),
  );
}
