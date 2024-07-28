import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/shared/global/app_colors.dart';
import 'package:todo/shared/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../shared/utils/app_routes.dart';
import '../../../shared/utils/navigation.dart';
import '../../components/logo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    // Add delay to simulate splash screen
    await Future.delayed(const Duration(seconds: DurationConstant.d3));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? user = prefs.getString('id');
    print('token: $token');
    print('user: $user');

    if (token != null && token.isNotEmpty) {

      navigateFinalTo(context: context, screenRoute: Routes.homeScreen);
    } else {

      navigateFinalTo(context: context, screenRoute: Routes.boarding);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: LogoWidget(),
      ),
    );
  }
}
