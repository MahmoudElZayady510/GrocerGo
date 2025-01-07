import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/common/widgets/back_arrow.dart';
import 'package:groceries/common/widgets/search_field.dart';
import 'package:groceries/core/configs/theme/app_colors.dart';
import 'package:groceries/presentation/cart/blocs/cart_bloc.dart';
import 'package:groceries/presentation/category/blocs/categories_bloc.dart';
import 'package:groceries/presentation/category/blocs/categories_bloc.dart';
import 'package:groceries/presentation/category/screens/add_products_to_firebase.dart';
import 'package:groceries/presentation/home/blocs/products_bloc.dart';

import '../../../common/widgets/cat_item_card.dart';
import '../../../common/widgets/product_card.dart';
import '../../../domain/cart/model/cart_item.dart';
import '../../search/blocs/search_bloc.dart';

class CategoryScreen extends StatelessWidget {
  String category;

  CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(15))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          BackArrow(),
                          SearchField(
                            controller: TextEditingController(),
                            enable: false,
                            width: 315,
                            onTap: () {
                              Navigator.pushNamed(context, '/search');
                              context.read<SearchBloc>().add(
                                  SearchResetEvent());
                            },
                          ),
                          BlocBuilder<CartBloc, CartState>(
                            builder: (context, state) {
                              if (state is CartLoaded){
                                return Visibility(
                                  visible: !(state.cartItems.isEmpty),
                                  child: Stack(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pushNamed(context, '/cart');
                                          },
                                          icon: Icon(Icons.shopping_cart)),
                                      Positioned(
                                          top: 0,
                                          left: 0,
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.circular(50),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.5),
                                                child: Text(state.cartItems.length.toString(),
                                                  style: TextStyle(
                                                    height: 0,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                );
                              }
                              else {
                                context.read<CartBloc>().add(FetchCartItemsEvent());
                                return IconButton(onPressed: () {
                                  Navigator.pushNamed(context, '/cart');
                                },
                                    icon: Icon(Icons.shopping_cart));
                              }
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      BlocBuilder<CategoriesBloc, CategoriesState>(
                        builder: (context, state) {
                          if (state is CategoriesLoaded) {
                            return Text(
                              category,
                              style:
                              TextStyle(fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            );
                          } else {
                            return Text('error');
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 100,
                  child: BlocConsumer<CategoriesBloc, CategoriesState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is CategoriesLoading) {
                        context.read<CategoriesBloc>().add(FetchCategoryList());
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is CategoriesLoaded) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.categories.length,
                            itemBuilder: (context, index) {
                              final item = state.categories[index];
                              String name = '';
                              print(item);
                              return CartegoryItemCard(
                                isSelected: item.name == state.selectedCategory,
                                category: item.name,
                                image: item.image,
                                onTap: () {
                                  context
                                      .read<CategoriesBloc>()
                                      .add(SelectCategory(
                                      currentCategory: item.name));
                                  // category = item.name;
                                  context.read<ProductsBloc>().add(
                                      FetchGroceryListByCategory(
                                          category: item.name));
                                  // name = item.name;
                                  // print(name);
                                  // print(item.name == name);
                                },
                              );
                            });
                      } else {
                        return Center(
                          child: Text('Unknown Error'),
                        );
                      }
                    },
                  ),
                ),
                BlocConsumer<ProductsBloc, ProductsState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is ProductsLoading) {
                      // context
                      //     .read<ProductsBloc>()
                      //     .add(FetchGroceryListByCategory(category: category));
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ProductsLoaded) {
                      return Expanded(
                        child: GridView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // 2 items per row
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio:
                              0.9, // Adjust this to match your card ratio
                            ),
                            itemCount: state.groceries.length,
                            itemBuilder: (context, index) {
                              final item = state.groceries[index];
                              return ProductCard(
                                id: item.id,
                                name: item.name,
                                image: item.image,
                                price: item.price,
                                description: item.description,
                                category: item.category,
                              );
                            }),
                      );
                    } else if (state is ProductsError) {
                      return Center(child: Text('Error: ${state.error}'));
                    } else {
                      return Center(child: Text('Unknown Error'));
                    }
                  },
                )
              ],
            ))

      // BlocConsumer<ProductsBloc, ProductsState>(
      //   listener: (context, state) {
      //     // TODO: implement listener
      //   },
      //   builder: (context, state) {
      //     if (state is ProductsLoading) {
      //       // context.read<ProductsBloc>().add(FetchGroceryListByCategory(category: category));
      //       return Center(child: CircularProgressIndicator());
      //     }
      //     else if (state is ProductsLoaded) {
      //       return SafeArea(
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Column(
      //             children: [
      //               SearchField(
      //                 controller: TextEditingController(),
      //                 enable: true,
      //                 width: 400,
      //                 onTap: (){
      //                   Navigator.pushNamed(context, '/search');
      //                 },
      //               ),
      //               SizedBox(
      //                 height: 20,
      //               ),
      //               SizedBox(
      //                 height: 100,
      //                 child: BlocConsumer<CategoriesBloc, CategoriesState>(
      //                   listener: (context, state) {
      //                     // TODO: implement listener
      //                   },
      //                   builder: (context, state) {
      //                     if (state is CategoriesLoading){
      //                       context.read<CategoriesBloc>().add(FetchCategoryList());
      //                       return Center(child: CircularProgressIndicator(),);
      //                     }
      //                     else if (state is CategoriesLoaded){
      //                       return ListView.builder(
      //                           scrollDirection: Axis.horizontal,
      //                           itemCount: state.categories.length,
      //                           itemBuilder: (context, index) {
      //                             final category = state.categories[index];
      //                             print(category);
      //                             return CartegoryItemCard(
      //                                 category: category.name,
      //                                 image: category.image,
      //                               onTap: (){
      //                                   context.read<ProductsBloc>().add(FetchGroceryListByCategory(category: category.name));
      //                               },
      //                             );
      //                           });
      //                     }
      //                    else {
      //                      return Center(child: Text('Unknown Error'),);
      //                     }
      //                   },
      //                 ),
      //               ),
      //               Expanded(
      //                 child: GridView.builder(
      //                     gridDelegate:
      //                     const SliverGridDelegateWithFixedCrossAxisCount(
      //                       crossAxisCount: 2, // 2 items per row
      //                       crossAxisSpacing: 10,
      //                       mainAxisSpacing: 0,
      //                       childAspectRatio:
      //                       0.8, // Adjust this to match your card ratio
      //                     ),
      //                     itemCount: state.groceries.length,
      //                     itemBuilder: (context, index) {
      //                       final item = state.groceries[index];
      //                       return ProductCard(
      //                         id: item.id,
      //                         name: item.name,
      //                         image: item.image,
      //                         price: item.price,
      //                       );
      //                     }),
      //               )
      //             ],
      //           ),
      //         ),
      //       );
      //     }
      //     else if (state is ProductsError) {
      //       return Center(child: Text('Error: ${state.error}'));
      //     }
      //     else {
      //       return Center(child: Text('Unknown Error'));
      //     }
      //   },
      // ),
    );
  }
}
