import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:kidame_gebiya/app_constant.dart';
import 'package:kidame_gebiya/features/home/presentation/pages/home_page.dart';
import 'package:kidame_gebiya/features/product/presentation/pages/products_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final List<Widget> _screens = <Widget>[
    const HomePage(),
    const ProductsPage(),
    const Scaffold(),
    const Scaffold(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _screens.length,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: _screens,
          ),
          bottomNavigationBar: Container(
            height: 58,
            padding: const EdgeInsets.only(top: 4),
            child: const TabBar(
              tabs: [
                Tab(
                  text: 'Home',
                  icon: Icon(FeatherIcons.home, size: 30),
                  iconMargin: EdgeInsets.only(bottom: 4),
                ),
                Tab(
                  text: 'Explore',
                  icon: Icon(FeatherIcons.search, size: 30),
                  iconMargin: EdgeInsets.only(bottom: 4),
                ),
                Tab(
                  text: 'Cart',
                  icon: Icon(FeatherIcons.shoppingCart, size: 30),
                  iconMargin: EdgeInsets.only(bottom: 4),
                ),
                Tab(
                  text: 'Profile',
                  icon: Icon(FeatherIcons.user, size: 30),
                  iconMargin: EdgeInsets.only(bottom: 4),
                ),
              ],
              indicator: BoxDecoration(),
              unselectedLabelStyle: TextStyle(
                  color: darkGreyColor, 
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
              labelStyle: TextStyle(
                  color: primaryColor, 
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          )),
    );
  }
}