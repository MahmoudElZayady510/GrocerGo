import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceries/presentation/auth/screens/contiue_screen.dart';
import 'package:groceries/presentation/auth/screens/hey_there_screen.dart';
import 'package:groceries/presentation/auth/screens/login_screen.dart';
import 'package:groceries/presentation/auth/screens/signup_screen.dart';
import 'package:groceries/presentation/cart/screens/cart_screen.dart';
import 'package:groceries/presentation/category/screens/products_by_category.dart';
import 'package:groceries/presentation/home/screens/home_screen.dart';
import 'package:groceries/presentation/search/screens/search_filters.dart';
import 'package:groceries/presentation/search/screens/search_screen.dart';

import '../presentation/product_details/screens/details_screen.dart';
import '../presentation/temporary_navigation/temp_nav.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    // Check user authentication status
    final isUserAuthenticated = auth.currentUser != null;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            // builder: (_) => isUserAuthenticated ? HomeScreen() : HeyThereScreen(),
            builder: (_) => isUserAuthenticated ? NavigationScreen() : HeyThereScreen(),
            // builder: (_) => false ? HomeScreen() : HeyThereScreen(),
        );
      case '/continue':
        return MaterialPageRoute(builder: (_) => ContiueScreen());
      case '/signin':
        return MaterialPageRoute(
          builder: (_) =>
          SignInScreen()
        );
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case '/filters':
        return MaterialPageRoute(builder: (_) => SearchFilters());
      case '/details':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => DetailsScreen(
            id: args['id'] ?? 'id',
            name: args['name'] ?? 'noName',
            image: args['image'] ?? 'image',
            description: args['description'] ?? 'noDesc',
            price: args['price'] ?? 999999999,
            category: args['category'] ?? 'noCat',
            unit: args['unit'] ?? 'Unit',
          ),
        );
      case '/category':
        final args = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_)=> CategoryScreen(
              category: args,
            ));
      case '/search':
        return MaterialPageRoute(
            builder: (_) => SearchScreen());
      case '/cart':
        return MaterialPageRoute(builder: (_) => CartScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
