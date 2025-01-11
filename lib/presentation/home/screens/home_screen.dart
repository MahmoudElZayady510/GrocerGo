import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/common/widgets/search_field.dart';
import 'package:groceries/core/configs/theme/app_colors.dart';
import 'package:groceries/presentation/home/blocs/best_sellings/best_selling_bloc.dart';
import 'package:groceries/presentation/home/blocs/new_arrival_bloc/new_arrival_bloc.dart';
import 'package:groceries/presentation/user_profile/blocs/user_info_bloc.dart';

import '../../../common/widgets/cat_item_card.dart';
import '../../../common/widgets/product_card.dart';
import '../../../data/Home/repositories/product.dart';
import '../../category/blocs/categories_bloc.dart';
import '../blocs/products_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List myCategory = [
    'food', 'fruits', 'health', 'care', 'cats'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //appbar with search
            Container(
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))
              ),
              width: double.infinity,

              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'Deliver to Location ',
                            style: TextStyle(color: Colors.white),
                          ),
                          BlocBuilder<UserInfoBloc,UserInfoState>(
                              builder: (context, state) {
                                if (state is UserInfoLoading) {
                                  context.read<UserInfoBloc>().add(FetchUserInfo());
                                }
                                if(state is UserInfoLoaded){
                                  return Text(state.userData.address,
                                    style: TextStyle(color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                    ),
                                  );
                                }
                                else {
                                  print('not loaded');
                                  return Text('');
                                }
                              }
                              )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: SearchField(
                          controller: TextEditingController(),
                          enable: false,
                          width: 400,
                          onTap: (){
                            Navigator.pushNamed(context, '/search');
                          },
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 80,
                    child: BlocConsumer<CategoriesBloc, CategoriesState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        if (state is CategoriesLoading){
                          context.read<CategoriesBloc>().add(FetchCategoryList());
                          return Center(child: CircularProgressIndicator(),);
                        }
                        else if (state is CategoriesLoaded){
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.categories.length,
                            itemBuilder: (context, index) {
                              final item = state.categories[index];
                              return CartegoryItemCard(
                                isSelected: false,
                                category: item.name,
                                  image:item.image,
                                onTap: (){
                                  context.read<ProductsBloc>().add(FetchGroceryListByCategory(category: item.name));
                                  Navigator.pushNamed(context, '/category',arguments:item.name);
                                },
                              );
                            });}
                        else {
                          return Text('error');
                        }
                      },
                    ),
                  ),
                  Text('Get all you need online',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 5,),
                  GestureDetector(
                    onTap: (){
                      context.read<ProductsBloc>().add(FetchGroceryListByCategory(category: 'Vegetables'));
                      Navigator.pushNamed(context, '/category',arguments:'Vegetables');
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/pics/banner.png',
                          // height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                      ),
                      // child: Image.network('https://media.istockphoto.com/id/1040917000/photo/collection-of-packaged-food-on-grey-background-3d-illustration.jpg?s=2048x2048&w=is&k=20&c=8LRX-RuwrDeqNNkpCS9m6dylrfL7NxSQSHifGWTnta8=',
                      //   height: 200,
                      //   width: double.infinity,
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Best Selling',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 10,),
                  _bestSelling(),
                  SizedBox(height: 10,),
                  Text('New Arrival',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 10,),
                  _newArrival()
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       flex : 1,
                  //       child: ClipRRect(
                  //         borderRadius: BorderRadius.circular(10),
                  //         child: Image.network('https://media.istockphoto.com/id/1961142003/photo/hazelnut-chocolate-truffles.jpg?s=2048x2048&w=is&k=20&c=_-6Mu5eJT6wo2S53G_1tLwP-iIy9x9_Q94mSfjx7k7s=',
                  //           // height: 150,
                  //           // width: 50,
                  //           // fit: BoxFit.cover,
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(width: 10,),
                  //     Expanded(
                  //       flex: 1,
                  //       child: ClipRRect(
                  //         borderRadius: BorderRadius.circular(10),
                  //         child: Image.network('https://images.unsplash.com/photo-1649361562904-316e772cf80a?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  //           // height: 150,
                  //           // fit: BoxFit.cover,
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _bestSelling(){
    return BlocConsumer<BestSellingBloc, BestSellingState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is BestSellingLoading) {
          print('state is loading');
          context.read<BestSellingBloc>().add(FetchBestSellingList());
          return Center(child: CircularProgressIndicator());
        } else if (state is BestSellingLoaded) {
          print('state is loaded');
          return SizedBox(
            // width: 100,
            height: 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.groceries.length,
                itemBuilder: (context, index) {
                  final item = state.groceries[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ProductCard(name: item.name,
                        image: item.image,
                        price: item.price,
                        id: item.id,
                        description: item.description,
                      category: item.category,
                      unit: item.unit,
                    ),
                  );
                }),
          );
        } else if (state is BestSellingError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Center(child: Text('Unknown Error'));
        }
      },
    );
  }

  Widget _newArrival(){
    return BlocConsumer<NewArrivalBloc, NewArrivalState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is NewArrivalLoading) {
          print('state is loading');
          context.read<NewArrivalBloc>().add(FetchNewArrivalList());
          return Center(child: CircularProgressIndicator());
        } else if (state is NewArrivalLoaded) {
          print('state is loaded');
          return SizedBox(
            // width: 100,
            height: 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.groceries.length,
                itemBuilder: (context, index) {
                  final item = state.groceries[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ProductCard(name: item.name,
                      image: item.image,
                      price: item.price,
                      id: item.id,
                      description: item.description,
                      category: item.category,
                      unit: item.unit,
                    ),
                  );
                }),
          );
        } else if (state is NewArrivalError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Center(child: Text('Unknown Error'));
        }
      },
    );
  }
}
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Groceries')),
//       body: BlocBuilder<ProductsBloc, ProductsState>(
//         builder: (context, state) {
//           if (state is ProductsLoading) {
//             context.read<ProductsBloc>().add(
//               FetchGroceryList(),
//             );
//             return Center(child: CircularProgressIndicator());
//           } else if (state is ProductsLoaded) {
//             return ListView.builder(
//               itemCount: state.groceries.length,
//               itemBuilder: (context, index) {
//                 final item = state.groceries[index];
//                 print(item);
//                 return GestureDetector(
//                   onTap: (){
//                     Navigator.pushNamed(context, '/details',
//                       arguments: {
//                         'id' :item.id,
//                         'name' : item.name,
//                         'image' : item.image,
//                         'description': item.description
//                       }
//                     );
//                   },
//                   child: ListTile(
//                     title: Text(item.name),
//                     subtitle: Text('\$${item.price}'),
//                     leading: Image.network(item.image),
//                   ),
//                 );
//               },
//             );
//           } else if (state is ProductsError) {
//             return Center(child: Text('Error: ${state.error}'));
//           }
//           return Center(child: Text('Unknown state'));
//         },
//       )
//     );
//   }
// }
