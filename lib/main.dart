import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kidame_gebiya/core/locator/locator.dart';
import 'package:kidame_gebiya/core/router/route_config.dart';
import 'package:kidame_gebiya/features/auth/bloc/auth_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark
    )
  );
  runApp(
    BlocProvider(
      create: (context) => AuthCubit(),
      child: MyApp(preferences: prefs))
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.preferences});
  final SharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ቅዳሜ ገቢያ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins'
      ),
      routerConfig: RouteConfig.returnRouter(preferences),
    );
  }
}
