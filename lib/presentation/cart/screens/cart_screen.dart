import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/common/widgets/back_arrow.dart';
import 'package:groceries/core/configs/theme/app_colors.dart';

import '../blocs/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  double totalPrice = 0.0;
  double deliveryFee = 12;
  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //appbar
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))
            ),
            child: SafeArea(
                child: Row(
                  children: [
                    Visibility(
                        visible: Navigator.canPop(context),
                        child: BackArrow()),
                    Expanded(
                      child: Center(
                        child: Text('Cart',
                          style: TextStyle(
                            height: 2,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: Navigator.canPop(context),
                      child: FloatingActionButton( // just for alignment
                          mini: true,
                          elevation: 0,
                          // backgroundColor: AppColors.secondBackgroundColor,
                          backgroundColor: Colors.transparent,
                          child: Icon(Icons.arrow_back_ios_sharp,
                          color: Colors.transparent,
                          ),
                          onPressed: (){
                            Navigator.of(context).pop();
                          }),
                    )
                  ],
                )),
          ),
          Expanded(
            child: BlocConsumer<CartBloc, CartState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if(state is CartLoading){
                  context.read<CartBloc>().add(
                    FetchCartItemsEvent(),
                  );
                  return Center(child: CircularProgressIndicator());
                }
                else if (state is CartLoaded){
                  totalPrice = state.cartItems.fold(0.0, (sum, item) => sum + item.price * item.quantity);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.cartItems.length,
                            itemBuilder: (context, index) {
                              final item = state.cartItems[index];
                              return Column(
                                children: [
                                  CartItemCard(
                                    itemId: item.id,
                                    name: item.name,
                                    image: item.image,
                                    price: item.price,
                                    quantity: item.quantity,
                                    description: item.description,
                                    category: item.category,
                                  ),
                                  Divider(
                                    color: Color(0xffCDC7AB),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text('Payment summary',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Cart total',
                              style: TextStyle(
                                  fontWeight: FontWeight.w100
                              ),
                            ),
                            Text(totalPrice.toStringAsFixed(2) + ' EGP',
                              style: TextStyle(
                                  fontWeight: FontWeight.w100
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delivery fees'),
                            Text( totalPrice == 0 ?
                                '0 Egp'
                                :
                            deliveryFee.toString() + ' EGP'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Discount'),
                            Text('0 EGP')
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total amount',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            Text((totalPrice+deliveryFee).toStringAsFixed(2),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {},
                            child: Text('CHECKOUT'),
                            style: ElevatedButton.styleFrom(
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
                else {
                  return Text('Item is empty');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CartItemCard extends StatelessWidget {

  final String itemId;
  final String name;
  final String image;
  final String category;
  final String description;
  final int quantity;
  final double price;
  const CartItemCard({super.key, required this.name, required this.image, required this.quantity, required this.price, required this.itemId, required this.description, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              print('object');
              Navigator.pushNamed(context, '/details' , arguments: {
                'id' : itemId,
                'name' : name,
                'image' : image,
                'description': description,
                'price' : price,
                'category': category
              });
            },
            child: Row(
              children: [
                Image.network(
                  image,
                  width: 90,
                ),
                SizedBox(width: 8,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name),
                    Text(price.toString() + ' EGP'),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    if (quantity > 1) {
                      context.read<CartBloc>().add(
                          UpdateItemEvent(itemId, quantity - 1));
                    }
                    else if (quantity == 1){
                      context.read<CartBloc>().add(RemoveItemEvent(itemId));
                    }
                  },
                  icon: quantity == 1 ? Icon(Icons.delete_forever , color: Colors.red,)
                      :
                  Icon(Icons.remove , color: AppColors.grey),
                ),
                SizedBox(width: 10,),
                Text(quantity.toString()),
                SizedBox(width: 10,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.grey,
                        width: 1
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(onPressed: () {
                    context.read<CartBloc>().add(UpdateItemEvent(itemId, quantity + 1));
                  },
                      icon: Icon(
                        Icons.add,
                        color: AppColors.secondaryColor,)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


// class CartScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Cart')),
//       body: BlocBuilder<CartBloc, CartState>(
//         builder: (context, state) {
//           if (state is CartLoading) {
//             print('fetching');
//             context.read<CartBloc>().add(
//               FetchCartItemsEvent(),
//             );
//             return Center(child: CircularProgressIndicator());
//           } else if (state is CartLoaded) {
//             return ListView.builder(
//               itemCount: state.cartItems.length,
//               itemBuilder: (context, index) {
//                 final item = state.cartItems[index];
//
//                 return ListTile(
//                   title: Text(item.name),
//                   subtitle: Text('Price: \$${item.price}'),
//                   trailing: Text('Qty: ${item.quantity}'),
//                 );
//               },
//             );
//           }else {
//             return Center(child: Text('Cart is empty.'));
//           }
//         },
//       ),
//     );
//   }
// }
