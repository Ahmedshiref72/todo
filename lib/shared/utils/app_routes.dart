
import 'package:flutter/material.dart';
import 'package:todo/auth/presentation/screens/login_screen.dart';
import 'package:todo/auth/presentation/screens/register_screen.dart';

import '../../home/componantes/qr.dart';
import '../../home/presentation/screens/add_new_task_screen.dart';
import '../../home/presentation/screens/homescreen.dart';
import '../../home/presentation/screens/one_task_screen.dart';
import '../../home/presentation/screens/profile_screen.dart';
import '../../opening/presentation/screens/board.dart';
import '../../opening/presentation/screens/splash_screen.dart';
import 'app_strings.dart';

class Routes {
  static const String home = '/';
  static const String splash = '/splash';
  static const String homeScreen = '/homeScreen';
  static const String loginScreen = '/loginScreen';
  static const String boarding = '/boarding';
  static const String registerScreen = '/registerScreen';
  static const String taskDetailScreen = '/taskDetailScreen';
  static const String profileScreen = '/profileScreen';
  static const String qrScreen = '/qrScreen';
  static const String addNewTaskScreen = '/addNewTaskScreen';



}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) =>  const SplashScreen(),
        );

      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) =>  const HomeScreen());
        case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) =>   LoginScreen());
        case Routes.boarding:
        return MaterialPageRoute(builder: (_) =>   const BoardingScreen());
        case Routes.registerScreen:
        return MaterialPageRoute(builder: (_) =>   RegisterScreen());
          case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) =>   const ProfileScreen());
        case Routes.qrScreen:
        return MaterialPageRoute(builder: (_) =>   QRScannerScreen());
        case Routes.addNewTaskScreen:
        return MaterialPageRoute(builder: (_) =>   AddNewTaskScreen());
      case Routes.taskDetailScreen:
        final taskId = routeSettings.arguments as String;
        return MaterialPageRoute(builder: (_) => TaskDetailsScreen(taskId: taskId));

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.wrongScreen),
        ),
        body: const Center(child: Text(AppStrings.routeNotFound)),
      ),
    );
  }
}
