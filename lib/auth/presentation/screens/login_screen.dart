import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:todo/shared/components/toast_component.dart';
import 'package:todo/shared/utils/app_values.dart';
import '../../../shared/global/app_colors.dart';
import '../../../shared/utils/app_assets.dart';
import '../../../shared/utils/app_routes.dart';
import '../../../shared/utils/navigation.dart';
import '../controller/auth_cubit.dart';
import '../controller/auth_states.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginSuccess) {
            showToast(
                text: 'User logged in successfully',
                state: ToastStates.SUCCESS);
           navigateFinalTo(context: context, screenRoute: Routes.homeScreen);
          } else if (state is AuthLoginError) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Stack(

              children: [

                Padding(
                  padding:  EdgeInsets.only(top: mediaQueryHeight(context) * 0.1),
                  child: Image.asset(ImageAssets.login,
                      height: mediaQueryHeight(context) * 0.5,
                      width: mediaQueryHeight(context),
                      fit: BoxFit.cover),
                ),
               Padding(
                 padding: const EdgeInsets.all(16),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.stretch,

                   children: [
                     SizedBox(height: mediaQueryHeight(context) * 0.55),
                     const Align(
                       alignment: Alignment.topLeft,
                       child: Text(
                         'Login',
                         style: TextStyle(
                           fontSize: 32,
                           fontWeight: FontWeight.bold,
                         ),
                         textAlign: TextAlign.center,
                       ),
                     ),
                     SizedBox(height: mediaQueryHeight(context) * 0.01),
                     IntlPhoneField(
                       controller: _phoneNumberController,
                       decoration: const InputDecoration(
                         contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                         labelText: 'Phone Number',
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(20)),
                           borderSide: BorderSide(color: AppColors.boldGrey),
                         ),
                         enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(20)),
                           borderSide: BorderSide(color: AppColors.boldGrey),
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(20)),
                           borderSide: BorderSide(color: AppColors.boldGrey),
                         ),
                       ),
                       initialCountryCode: 'EG',
                       onChanged: (phone) {
                         print(phone.completeNumber);
                       },
                     ),
                     SizedBox(height: mediaQueryHeight(context) * 0.01),
                     TextField(
                       controller: _passwordController,
                       obscureText: AuthCubit.get(context).isObsecured,
                       decoration: InputDecoration(
                         contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                         border: const OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(20)),
                           borderSide: BorderSide(color: AppColors.boldGrey),
                         ),
                         enabledBorder: const OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(20)),
                           borderSide: BorderSide(color: AppColors.boldGrey),
                         ),
                         focusedBorder: const OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(20)),
                           borderSide: BorderSide(color: AppColors.boldGrey),
                         ),
                         labelText: 'Password',
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
                     SizedBox(height: mediaQueryHeight(context) * 0.04),
                     state is AuthLoginLoading
                         ? const Center(child: CircularProgressIndicator())
                         : ElevatedButton(
                       onPressed: () {
                         String phoneNumber =
                             '+20' + _phoneNumberController.text;

                         BlocProvider.of<AuthCubit>(context).login(
                           phoneNumber,
                           _passwordController.text,
                         );
                       },
                       style: ElevatedButton.styleFrom(
                         padding: EdgeInsets.symmetric(vertical: 16),
                         textStyle: TextStyle(fontSize: 18),
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(20),
                         ),
                         backgroundColor: AppColors.primary,
                       ),
                       child: Text('Sign In',
                           style: TextStyle(color: AppColors.offWhite)),
                     ),
                     SizedBox(height: mediaQueryHeight(context) * 0.02),
                     TextButton(
                       onPressed: () {
                         navigateTo(
                             context: context, screenRoute: Routes.registerScreen);
                       },
                       child: const Text.rich(
                         TextSpan(
                           text: 'Didn’t have any account? ',
                           style: TextStyle(color: AppColors.boldGrey, fontSize: 14),
                           children: [
                             TextSpan(
                               text: 'Sign Up here',
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
               )
              ],
            ),
          );
        },
      ),
    );
  }
}
