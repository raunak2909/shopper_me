

import 'package:flutter/material.dart';
import 'package:shopper_me/screens/all_products/all_products_page.dart';
import 'package:shopper_me/screens/splash/splash_page.dart';

import '../screens/home/home_page.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String homeScreen = '/home_screen';

  static const String allProductsScreen = '/all_products_screen';



  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashPage(),
    homeScreen: (context) => HomePage(),
    allProductsScreen: (context) => AllProductsPage()
  };
}
