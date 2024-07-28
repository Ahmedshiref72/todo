import 'package:todo/auth/presentation/controller/auth_cubit.dart';
import 'package:todo/home/presentation/controller/home_controller/home_cubit.dart';
import 'package:todo/home/presentation/controller/one_task_controller/one_task_cubit.dart';
import 'package:todo/shared/global/app_theme.dart';
import 'package:todo/shared/network/dio_helper.dart';
import 'package:todo/shared/utils/app_routes.dart';
import 'package:todo/shared/utils/app_strings.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home/presentation/controller/add_new_task_controller/add_new_tsk_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => HomeCubit()),
        BlocProvider(create: (BuildContext context) => AuthCubit()),
        BlocProvider(create: (BuildContext context) => TodoCubit()),
        BlocProvider(create: (BuildContext context) => TaskCubit()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        onGenerateRoute: RouteGenerator.getRoute,
        navigatorKey: DioHelper.navigatorKey,
        theme: lightTheme,
        title: AppStrings.appTitle,
      ),
    );
  }
}
