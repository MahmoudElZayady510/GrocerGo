import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceries/common/cart_repository.dart';
import 'package:groceries/data/cart/repository/firebase_cart_repo.dart';
import 'package:groceries/presentation/auth/screens/hey_there_screen.dart';
import 'package:groceries/presentation/cart/blocs/cart_bloc.dart';
import 'package:groceries/presentation/cart/screens/cart_screen.dart';
import 'package:groceries/presentation/home/blocs/products_bloc.dart';
import 'common/route_generator.dart';
import 'data/Home/repositories/firebase_fetchProducts.dart';
import 'data/Home/repositories/product.dart';
import 'data/auth/repository/auth_repository.dart';

import 'domain/Home/usecases/fetch_products_usecase.dart';
import 'domain/auth/use_cases/login_user.dart';
import 'domain/auth/use_cases/logout_user.dart';
import 'domain/auth/use_cases/register_user.dart';
import 'presentation/auth/blocs/signin_bloc/sign_in_bloc.dart';
import 'presentation/auth/blocs/signup_bloc/sign_up_bloc.dart';

import 'presentation/home/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final firestore = FirebaseFirestore.instance;
  final groceryRepository = FirebaseGroceryRepository(firestore);
  final cartRepository = FirebaseCartRepository(firestore);

  runApp(
    MyApp(
      groceryRepository: groceryRepository,
      cartRepository: cartRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final FirebaseGroceryRepository groceryRepository;
  final FirebaseCartRepository cartRepository;

  const MyApp({Key? key, required this.groceryRepository,
    required this.cartRepository
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirebaseGroceryRepository>(
          create: (_) => groceryRepository,
        ),
        RepositoryProvider<FirebaseCartRepository>(
            create: (_) => cartRepository,)
        // auth repo not added
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ProductsBloc>(
            create: (context) => ProductsBloc(
              FetchGroceries(context.read<FirebaseGroceryRepository>()),
            ),
          ),
          BlocProvider(
              create: (context) => CartBloc(context.read<FirebaseCartRepository>()),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Grocery App',
          onGenerateRoute: RouteGenerator.generateRoute,
          // initialRoute: '/',
          home: HeyThereScreen(),
        ),
      ),
    );
  }
}


