import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceries/presentation/auth/screens/login_screen.dart';
import 'package:groceries/presentation/auth/screens/signup_screen.dart';
import 'package:groceries/presentation/home/screens/home_screen.dart';

import '../presentation/product_details/screens/details_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    // Check user authentication status
    final isUserAuthenticated = auth.currentUser != null;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) =>
          isUserAuthenticated ? HomeScreen() : SignInScreen(),
        );
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case '/details':
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => DetailsScreen(
            id: args['id'] ?? 'id',
            name: args['name'] ?? 'noName',
            image: args['image'] ?? 'image',
            description: args['description'] ?? 'noDesc',
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
