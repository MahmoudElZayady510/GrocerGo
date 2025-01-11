import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceries/data/cart/repository/cart_repository.dart';
import 'package:groceries/core/configs/theme/app_theme.dart';
import 'package:groceries/data/cart/repository/firebase_cart_repo.dart';
import 'package:groceries/data/category/repositories/firebase_fetchCategory.dart';
import 'package:groceries/data/search/repositories/firebase_search_repository.dart';
import 'package:groceries/data/user_settings/repositories/firebase_user_info.dart';
import 'package:groceries/data/user_settings/repositories/user_info.dart';
import 'package:groceries/domain/Home/usecases/fetch_bestSelling_usecase.dart';
import 'package:groceries/domain/Home/usecases/fetch_newArrival_usecase.dart';
import 'package:groceries/domain/Home/usecases/fetch_products_by_category.dart';
import 'package:groceries/domain/cart/usecases/add_item.dart';
import 'package:groceries/domain/cart/usecases/fetch_items.dart';
import 'package:groceries/domain/cart/usecases/remove_cart_item.dart';
import 'package:groceries/domain/cart/usecases/update_cart_item.dart';
import 'package:groceries/domain/category/usecases/fetch_categories_usecase.dart';
import 'package:groceries/domain/search/usecases/search_usecase.dart';
import 'package:groceries/domain/user_settings/usecases/user_info_useCase.dart';
import 'package:groceries/presentation/auth/blocs/signout_bloc/signout_bloc.dart';
import 'package:groceries/presentation/auth/screens/hey_there_screen.dart';
import 'package:groceries/presentation/auth/screens/login_screen.dart';
import 'package:groceries/presentation/cart/blocs/cart_bloc.dart';
import 'package:groceries/presentation/cart/screens/cart_screen.dart';
import 'package:groceries/presentation/category/blocs/categories_bloc.dart';
import 'package:groceries/presentation/category/screens/products_by_category.dart';
import 'package:groceries/presentation/home/blocs/best_sellings/best_selling_bloc.dart';
import 'package:groceries/presentation/home/blocs/new_arrival_bloc/new_arrival_bloc.dart';
import 'package:groceries/presentation/home/blocs/products_bloc.dart';
import 'package:groceries/presentation/product_details/blocs/similar_products_bloc.dart';
import 'package:groceries/presentation/search/blocs/search_bloc.dart';
import 'package:groceries/presentation/search/screens/search_screen.dart';
import 'package:groceries/presentation/temporary_navigation/temp_nav.dart';
import 'package:groceries/presentation/user_profile/blocs/user_info_bloc.dart';
import 'package:groceries/presentation/user_profile/screens/user_screen.dart';
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
import 'presentation/user_profile/screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final authRepository = FirebaseAuthRepository(firebaseAuth , firestore);
  final groceryRepository = FirebaseGroceryRepository(firestore);
  final cartRepository = FirebaseCartRepository(firebaseAuth,firestore);
  final categoryRepository = FirebaseCategoryRepository(firestore);
  final userInfoRepository = FirebaseUserInfoRepository(firestore , firebaseAuth);
  final searchRepository = FirebaseSearchRepository(firestore);
  final signUpUseCase = SignUpUseCase(authRepository);
  final addToCartUsecase = AddToCartUsecase(cartRepository);
  final fetchCartItemsUseCase = FetchCartItemsUseCase(cartRepository);
  final removeFromCartUsecase = RemoveFromCartUsecase(cartRepository);
  final updateCartItemUsecase = UpdateCartItemUsecase(cartRepository);
  final userInfoUsecase = FetchUserInfoUsecase(userInfoRepository);
  final searchUsecase = SearchUsecase(searchRepository);
  final signoutUsecase = LogoutUserUsecase(authRepository);
  final fetchBestSellingUsecase = FetchBestsellingUsecase(groceryRepository);
  final fetchNewArrivalUsecase = FetchNewArrivalUsecase(groceryRepository);
  final fetctGroceryByCategoryUsecase = FetchGroceriesByCategoryUsecase(groceryRepository);

  runApp(
    MyApp(
      authRepository: authRepository,
      groceryRepository: groceryRepository,
      cartRepository: cartRepository,
      categoryRepository: categoryRepository,
      signUpUseCase: signUpUseCase,
      addToCartUsecase: addToCartUsecase,
      fetchCartItemsUseCase: fetchCartItemsUseCase,
      updateCartItemUsecase: updateCartItemUsecase,
      removeFromCartUsecase: removeFromCartUsecase,
      fetchUserInfoUsecase: userInfoUsecase,
      userInfoRepository: userInfoRepository,
      searchRepository: searchRepository,
      searchUsecase: searchUsecase,
      logoutUserUsecase: signoutUsecase,
      fetchBestsellingUsecase: fetchBestSellingUsecase,
      fetchNewArrivalUsecase: fetchNewArrivalUsecase,
      fetchGroceriesByCategoryUsecase: fetctGroceryByCategoryUsecase,
    ),
  );
}

class MyApp extends StatelessWidget {
  final FirebaseAuthRepository authRepository;
  final FirebaseGroceryRepository groceryRepository;
  final FirebaseCartRepository cartRepository;
  final FirebaseCategoryRepository categoryRepository;
  final FirebaseUserInfoRepository userInfoRepository;
  final FirebaseSearchRepository searchRepository;
  final SignUpUseCase signUpUseCase;
  final AddToCartUsecase addToCartUsecase;
  final FetchCartItemsUseCase fetchCartItemsUseCase;
  final RemoveFromCartUsecase removeFromCartUsecase;
  final UpdateCartItemUsecase updateCartItemUsecase;
  final FetchUserInfoUsecase fetchUserInfoUsecase;
  final SearchUsecase searchUsecase;
  final LogoutUserUsecase logoutUserUsecase;
  final FetchBestsellingUsecase fetchBestsellingUsecase;
  final FetchNewArrivalUsecase fetchNewArrivalUsecase;
  final FetchGroceriesByCategoryUsecase fetchGroceriesByCategoryUsecase;

  const MyApp({Key? key, required this.groceryRepository,
    required this.cartRepository , required this.authRepository,
    required this.categoryRepository , required this.signUpUseCase, required this.addToCartUsecase, required this.fetchCartItemsUseCase, required this.removeFromCartUsecase, required this.updateCartItemUsecase, required this.fetchUserInfoUsecase, required this.userInfoRepository, required this.searchRepository, required this.searchUsecase, required this.logoutUserUsecase, required this.fetchBestsellingUsecase, required this.fetchNewArrivalUsecase, required this.fetchGroceriesByCategoryUsecase
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirebaseAuthRepository>(
            create: (_) => authRepository,
        ),
        RepositoryProvider<FirebaseGroceryRepository>(
          create: (_) => groceryRepository,
        ),
        RepositoryProvider<FirebaseCartRepository>(
            create: (_) => cartRepository,),
        RepositoryProvider<FirebaseCategoryRepository>(
            create: (_) => categoryRepository),
        RepositoryProvider<FirebaseUserInfoRepository>(
            create: (_) => userInfoRepository ),
        RepositoryProvider(
            create: (_) => searchRepository)
        // auth repo not added
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SignInBloc>(
              create: (context) => SignInBloc(authRepository: authRepository)
          ),
          BlocProvider<SignUpBloc>(
              create: (context) => SignUpBloc(signUpUseCase)
          ),
          BlocProvider(
              create: (context)=> SignoutBloc(logoutUserUsecase)),
          BlocProvider<ProductsBloc>(
            create: (context) => ProductsBloc(
              FetchGroceriesUsecase(context.read<FirebaseGroceryRepository>()),
              FetchGroceriesByCategoryUsecase(context.read<FirebaseGroceryRepository>()),
            ),
          ),
          BlocProvider(
              create: (context) => SimilarProductsBloc(fetchGroceriesByCategoryUsecase)
          ),
          BlocProvider(
              create: (context) => BestSellingBloc(fetchBestsellingUsecase)
          ),
          BlocProvider(
              create: (context) => NewArrivalBloc(fetchNewArrivalUsecase)
          ),
          BlocProvider(
              create: (context) => CartBloc( addToCartUsecase,fetchCartItemsUseCase,removeFromCartUsecase,updateCartItemUsecase),
          ),
          BlocProvider(
              create: (context) => CategoriesBloc(FetchCategories(context.read<FirebaseCategoryRepository>()))),
          BlocProvider(
              create: (context) => UserInfoBloc(FetchUserInfoUsecase(context.read<FirebaseUserInfoRepository>()))),
          BlocProvider(
              create: (context) => SearchBloc(SearchUsecase(context.read<FirebaseSearchRepository>())))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Grocery App',
          theme: AppTheme.appTheme,
          //dont forget to implement screen_utli
          //dont forget the real nav bar
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: '/',
          // home: SearchScreen(),
        ),
      ),
    );
  }
}


