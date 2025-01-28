import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kidame_gebiya/app_constant.dart';
import 'package:kidame_gebiya/features/auth/presentation/widgets/login_button.dart';
import 'package:kidame_gebiya/features/auth/presentation/widgets/password_field.dart';
import 'package:kidame_gebiya/features/auth/presentation/widgets/username_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kidame_gebiya/features/auth/bloc/auth_cubit.dart';
import 'package:kidame_gebiya/features/auth/bloc/auth_state.dart';

typedef LoginCallBack = Future<void> Function(String username, String password);  

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  Future<void> _handleLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().isUserValidate({
        "username": usernameController.text.trim(),
        "password": passwordController.text.trim(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is AuthSuccessful) {
            final preferences = await SharedPreferences.getInstance();
            await preferences.setBool('isLoggedIn', true);
            if (context.mounted) {
              context.go('/bottom-navigation');
            }
          }

          if (state is AuthError && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                  style: const TextStyle(color: Colors.red),
                ),
                backgroundColor: Colors.white,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 80),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset('assets/images/logo.png', width: 200),
                  const SizedBox(height: 50),
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  buildUsernameField(usernameController),
                  
                  const SizedBox(height: 20),
                  
                  BuildPasswordField(passwordController: passwordController,),
                  
                  const SizedBox(height: 40),
                  
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state){
                    return LoginButton(
                      onPressed: () => _handleLogin(context),
                      isLoading: state is AuthLoading,
                      buttonText: 'Log In',
                      backgroundColor: primaryColor,
                      textColor: Colors.white,
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}