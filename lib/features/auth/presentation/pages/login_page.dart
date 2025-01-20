import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kidame_gebiya/app_constant.dart';
import 'package:kidame_gebiya/features/auth/bloc/auth_cubit.dart';
import 'package:kidame_gebiya/features/auth/bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordHidden = true;
  
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  
  @override
  void dispose() {
    usernameController.clear();
    passwordController.clear();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) async{
          if(state is AuthSuccessful) {
            SharedPreferences preferences = await SharedPreferences.getInstance();
            preferences.setBool('isLoggedIn', true);
            if(context.mounted) {
              context.go('/homepage');
            }
          }
          
          if(state is AuthError){
            if(context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error, 
                  style: const TextStyle(color: Colors.red),), 
                backgroundColor: Colors.white,));
            }
          }
        },
        
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state){
            
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 80),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.asset('assets/images/logo.png', width: 200,),
                      
                      const SizedBox(height: 50),
                      
                      const Text('Welcome Back!',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                        ),
                      ),
                      
                      const SizedBox(height: 30),
                      
                      TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: greyColor),
                            borderRadius: BorderRadius.circular(8)
                          ),
                          focusedBorder:  OutlineInputBorder(
                            borderSide: const BorderSide(color: greyColor),
                            borderRadius: BorderRadius.circular(8)
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(8)
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: greyColor),
                            borderRadius: BorderRadius.circular(8)
                          ),
                          prefixIcon: const Icon(FeatherIcons.user, size: 28, color: darkGreyColor,),
                          hintText: 'Username',
                          hintStyle: const TextStyle(
                            fontSize: 16
                          ),
                          labelStyle: const TextStyle(
                            fontSize: 16
                          ), 
                        ),
                        validator: (value) {
                          if(value == null || value == ''){
                            return 'username can\'t be empty';
                          }
                          
                          if(value.trim().length < 3){
                            return 'username must be at least 3 characters';
                          }
                          
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 20),
                      
                      TextFormField(
                        controller: passwordController,
                        obscureText: isPasswordHidden,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: greyColor),
                            borderRadius: BorderRadius.circular(8)
                          ),
                          focusedBorder:  OutlineInputBorder(
                            borderSide: const BorderSide(color: greyColor),
                            borderRadius: BorderRadius.circular(8)
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(8)
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: greyColor),
                            borderRadius: BorderRadius.circular(8)
                          ),
                          prefixIcon: const Icon(Icons.lock_outlined, size: 28, color: darkGreyColor,),
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                            fontSize: 16
                          ),
                          labelStyle: const TextStyle(
                            fontSize: 16
                          ), 
                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                isPasswordHidden = !isPasswordHidden;
                              });
                            }, 
                            icon: Icon(isPasswordHidden ? FeatherIcons.eyeOff : FeatherIcons.eye, 
                              color: darkGreyColor,))
                        ),
                        validator: (value) {
                          if(value == null || value == ''){
                            return 'password can\'t be empty';
                          }
                          
                          if(value.trim().length < 6){
                            return 'password must be at least 6 characters';
                          }
                          
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 40),
                      
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              context.read<AuthCubit>().isUserValidate({
                                "username": usernameController.text,
                                "password": passwordController.text
                              });
                            }
                          }, 
                          style: TextButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                            )
                          ),
                          child: state is AuthLoading 
                          ? const CircularProgressIndicator(color: Colors.white,) 
                          : const Text('Login', 
                            style: TextStyle(
                              fontWeight: FontWeight.w500, 
                              fontSize: 20, 
                              color: Colors.white),)
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        )
      ),
    );
  }
}