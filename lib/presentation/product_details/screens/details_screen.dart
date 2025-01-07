import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/common/widgets/back_arrow.dart';
import 'package:groceries/common/widgets/product_card.dart';
import 'package:groceries/core/configs/theme/app_colors.dart';
import 'package:groceries/domain/cart/model/cart_item.dart';
import 'package:groceries/main.dart';
import 'package:groceries/presentation/cart/blocs/cart_bloc.dart';

import '../../home/blocs/products_bloc.dart';

class DetailsScreen extends StatefulWidget {
  final String id;
  final String name;
  final String category;
  final String image;
  final String description;
  final dynamic price;

  DetailsScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.category,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
                    color: AppColors.orange,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BackArrow(),
                          BlocBuilder<CartBloc, CartState>(
                            builder: (context, state) {
                              if (state is CartLoaded){
                                return Visibility(
                                  // visible: !state.cartItems.isEmpty,
                                  child: Stack(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pushNamed(context, '/cart');
                                          },
                                          icon: Icon(Icons.shopping_cart)),
                                      Visibility(
                                        visible: !(state.cartItems.length == 0),
                                        child: Positioned(
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
                                            )),
                                      )
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
                      Center(
                        child: Image.network(
                          widget.image,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text('Unit'),
                      const SizedBox(height: 8),
                      Text(
                        widget.description,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w100),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Similar Products',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BlocConsumer<ProductsBloc, ProductsState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          if (state is ProductsLoading) {
                            context.read<ProductsBloc>().add(
                                FetchGroceryListByCategory(
                                    category: widget.category));
                            return CircularProgressIndicator();
                          }
                          else if (state is ProductsLoaded) {
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
                                      ),
                                    );
                                  }),
                            );
                          }
                          else if (state is ProductsError) {
                           return Text(state.error);
                          }
                          else {
                            return Text('state error');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey, // Shadow color
                        blurRadius: 6.0, // Spread of the shadow
                        offset: Offset(0, 3), // Shadow offset (x, y)
                      ),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'EGP ' + (widget.price * quantity).toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (quantity > 1) {
                                quantity -= 1;
                              }
                            });
                            // if (quantity > 1) {
                            //   context.read<CartBloc>().add(
                            //       UpdateItemEvent(itemId, quantity - 1));
                            // }
                            // else if (quantity == 1){
                            //   context.read<CartBloc>().add(RemoveItemEvent(itemId));
                            // }
                          },
                          icon: Icon(Icons.remove),
                        ),
                        Text(quantity.toString()),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                quantity += 1;
                              });
                              // context.read<CartBloc>().add(UpdateItemEvent(itemId, quantity + 1));
                            },
                            icon: Icon(Icons.add))
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context.read<CartBloc>().add(AddItemEvent(CartItem(
                              name: widget.name,
                              id: widget.id,
                              image: widget.image,
                              price: widget.price,
                              quantity: quantity,
                              description: widget.description,
                            category: widget.category,
                          )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text('Add to cart'),
                        ))
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
