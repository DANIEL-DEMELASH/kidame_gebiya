import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kidame_gebiya/app_constant.dart';
import 'package:kidame_gebiya/features/user/bloc/user_bloc.dart';
import 'package:kidame_gebiya/features/user/bloc/user_event.dart';
import 'package:kidame_gebiya/features/user/bloc/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(FetchUser()),
      child: Scaffold(
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state){
            if(state is UserError){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.error, textAlign: TextAlign.center,),
                  
                  const SizedBox(height: 20),
                  
                  IconButton(
                    onPressed: (){
                      context.read<UserBloc>().add(FetchUser());
                    }, 
                    icon: const Icon(Icons.refresh, size: 30,))
                ],
              );
            }
            
            if(state is UserLoading){
              return const Center(child: CircularProgressIndicator());
            }
            
            if(state is UserLoaded){
              return SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      fit: StackFit.loose,
                      children: [
                        Container(
                          height: 160,
                          margin: const EdgeInsets.only(bottom: 100),
                          child: const Align(
                            alignment: Alignment.bottomCenter,
                            child: Divider(
                              color: greyColor,
                            ),
                          ),
                        ),
                        
                        Positioned(
                          top: 100,
                          left: 20,
                          child: CircleAvatar(
                            radius: 58,
                            backgroundColor: primaryColor,
                            child: CircleAvatar(
                              radius: 54,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: const Color(0xFFD9D9D9),
                                child: Text(
                                  state.user.name.firstname[0].toUpperCase(), 
                                  style: const TextStyle(fontSize: 70, color: Colors.black),),
                              ),
                            ),
                          ))
                      ],
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${state.user.name.firstname} ${state.user.name.lastname}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          
                          Text("@${state.user.username}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: darkGreyColor
                            ),
                          ),
                          
                          const SizedBox(height: 30),
                          
                          Row(
                            children: [
                              const Icon(Icons.email_outlined, color: darkGreyColor),
                              
                              const SizedBox(width: 12),
                              
                              Text(state.user.email,
                                style: const TextStyle(
                                  color: darkGreyColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          
                          const SizedBox(height: 20,),
                          
                          Row(
                            children: [
                              const Icon(FeatherIcons.mapPin, color: darkGreyColor),
                              
                              const SizedBox(width: 12),
                              
                              Text("${state.user.address.number} ${state.user.address.street} ${state.user.address.city}",
                                style: const TextStyle(
                                  color: darkGreyColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          
                          const SizedBox(height: 20,),
                          
                          Row(
                            children: [
                              const Icon(FeatherIcons.phone, color: darkGreyColor),
                              
                              const SizedBox(width: 12),
                              
                              Text(state.user.phone,
                                style: const TextStyle(
                                  color: darkGreyColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                            
                          const SizedBox(height: 20,),
                          
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(color: darkGreyColor)
                                ),
                                child: const Center(child: Text('ZIP', style: TextStyle(fontSize: 12, color: darkGreyColor, fontWeight: FontWeight.w500),)),
                              ),
                              
                              const SizedBox(width: 12),
                              
                              Text(state.user.address.zipcode,
                                style: const TextStyle(
                                  color: darkGreyColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),            
                        ],
                      ),
                    ),
                    
                    
                  ],
                ),
              );
            }
            
            return const SizedBox.shrink();
        }),
        
        bottomSheet: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(bottom: 12),
          child: GestureDetector(
            onTap: () async {
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.remove('isLoggedIn');
                sharedPreferences.remove('username');
                if(context.mounted) {
                  context.go('/login');
                }
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Icon(FeatherIcons.logOut, color: Colors.red),
                  
                  SizedBox(width: 12),
                  
                  Text("Logout",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      
    );
  }
}