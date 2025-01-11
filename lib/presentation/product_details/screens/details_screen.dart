import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groceries/common/widgets/back_arrow.dart';
import 'package:groceries/common/widgets/product_card.dart';
import 'package:groceries/core/configs/theme/app_colors.dart';
import 'package:groceries/domain/cart/model/cart_item.dart';
import 'package:groceries/main.dart';
import 'package:groceries/presentation/cart/blocs/cart_bloc.dart';
import 'package:groceries/presentation/product_details/blocs/similar_products_bloc.dart';

import '../../home/blocs/products_bloc.dart';

class DetailsScreen extends StatefulWidget {
  final String id;
  final String name;
  final String category;
  final String image;
  final String description;
  final String unit;
  final dynamic price;

  DetailsScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.category,
    required this.unit,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int quantity = 1;
  @override
  void initState() {
    super.initState();
    context.read<SimilarProductsBloc>().add(
        FetchSimilarProducts(category: widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                        color: AppColors.orange,
                      ),
                      child: SafeArea(
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
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(widget.unit,
                            style: TextStyle(
                              color: Color(0xff7C7C7C),
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Theme(
                            data: ThemeData(
                              fontFamily: GoogleFonts.glory().fontFamily,
                                dividerColor: Colors.transparent,
                            ),
                            child: ExpansionTile(
                              iconColor: AppColors.primaryColor,
                              tilePadding: EdgeInsets.all(0),
                                title: Text('Product Details',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                  ),
                                ),
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.description,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff7C7C7C)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Similar Products',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BlocConsumer<SimilarProductsBloc, SimilarProductsState>(
                                listener: (context, state) {
                                  // TODO: implement listener
                                },
                                builder: (context, state) {
                                  if (state is SimilarProductsLoading) {
                                    return CircularProgressIndicator();
                                  }
                                  else if (state is SimilarProductsLoaded) {
                                    state.groceries.removeWhere // not working with new & similar as different id
                                      ((grocery) => grocery.id == widget.id);
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
                                  }
                                  else if (state is SimilarProductsError) {
                                    return Text(state.message);
                                  }
                                  else {
                                    return Text('state error');
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
              left: 0,
              right: 0,
              child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              SizedBox(height: 5,),
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
                      'EGP ' + (widget.price * quantity).toStringAsFixed(2),
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
                              unit: widget.unit
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
          ))
        ]
      ),
    );
  }
}
