import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kidame_gebiya/features/cart/data/models/cart_model.dart';
import 'package:kidame_gebiya/features/cart/presentation/pages/cart_detail.dart';
import 'package:kidame_gebiya/features/cart/presentation/pages/carts_page.dart';
import 'package:kidame_gebiya/features/category/presentation/pages/category_page.dart';
import 'package:kidame_gebiya/features/product/data/models/product_model.dart';
import 'package:kidame_gebiya/features/product/presentation/pages/product_by_category.dart';
import 'package:kidame_gebiya/features/product/presentation/pages/product_detail.dart';
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
          path: '/carts',
          builder: (context, state) => const CartsPage(),
          routes: [
            GoRoute(
            path: '/cart_detail',
            builder: (context, state){
              final CartModel cartModel = state.extra as CartModel;
              return CartDetail(cartModel: cartModel);
            },
          ),
          ]
        ),
        
        GoRoute(
          path: '/categories',
          builder: (context, state) => const CategoryPage(),
          routes: [
            GoRoute(
              path: '/products',
               builder: (context, state) {
                final productCategory = state.extra as String?;
                if(productCategory == null){
                  return const Scaffold(body: Center(child: Text('Invalid product category'),));
                }
                return ProductByCategory(productCategory: productCategory);
              }
            )
          ]
        ),
        
        GoRoute(
          path: '/homepage',
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              path: '/product_detail',
              builder: (context, state) {
                final product = state.extra as ProductModel?;
                if(product == null){
                  return const Scaffold(body: Center(child: Text('Invalid product'),));
                }
                return ProductDetail(product: product);
              }
            )
          ]
        )
      ]
    );
    
    return router;
  }
}