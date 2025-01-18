import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kidame_gebiya/core/locator/locator.dart';
import 'package:kidame_gebiya/features/auth/bloc/auth_cubit.dart';
import 'package:kidame_gebiya/features/auth/presentation/pages/login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(
    BlocProvider(
      create: (context) => AuthCubit(),
      child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ቅዳሜ ገቢያ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins'
      ),
      home: const LoginPage(),
    );
  }
}
