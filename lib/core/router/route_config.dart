import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kidame_gebiya/features/auth/presentation/pages/login_page.dart';
import 'package:kidame_gebiya/features/bottom-navigation/bottom_navigation.dart';
import 'package:kidame_gebiya/features/home/presentation/pages/home_page.dart';

class RouteConfig {
  static String initialLocation = '/';
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  
  static GoRouter returnRouter(SharedPreferences prefs) {
    GoRouter router = GoRouter(
      initialLocation: initialLocation,
      navigatorKey: _rootNavigatorKey,    
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            if(prefs.getBool('isLoggedIn') == null || prefs.getBool('isLoggedIn') == false){
              return const LoginPage();
            }else{
              return const BottomNavigation();
            }
          },
        ),
        
        GoRoute(
          path: '/bottom-navigation',
          builder: (context, state) => const BottomNavigation(),
        ),
        
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        
        GoRoute(
          path: '/homepage',
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              path: '/product_detail',
              builder: (context, state) => Scaffold(body: Center(child: ElevatedButton(onPressed: () => context.pop(), child: const Text('Product Detail')),),),
            )
          ]
        )
      ]
    );
    
    return router;
  }
}