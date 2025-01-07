import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/core/configs/theme/app_colors.dart';

import '../../domain/cart/model/cart_item.dart';
import '../../presentation/cart/blocs/cart_bloc.dart';
import '../../presentation/category/screens/add_products_to_firebase.dart';

class ProductCard extends StatelessWidget {

  final String id;
  final String name;
  final String image;
  final String category;
  final String description;
  final double price;

  // final addProducts add = new addProducts();
  ProductCard({
    // const ProductCard({
    super.key,
    required this.name,
    required this.image,
    required this.price, required this.id, required this.description, required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/details' ,arguments: {
          'id' : id,
          'name' : name,
          'image' : image,
          'description' : description,
          'price' : price,
          'category': category,
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color(0xff7C7C7C),
          ),
          color: AppColors.backgroundColor
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 5,),
              ClipRRect(
                child: Image.network(
                    image,
                  width: 150,
                  height: 80,
                  fit: BoxFit.scaleDown,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                ),
              ),
              SizedBox(height: 22,),
              SizedBox(
                width: 150, // same as pic
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(price.toString() + ' EGP'),
                   SizedBox(
                     height: 45,
                     width: 45,
                     child: Container(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20),
                         color: AppColors.secondaryColor,
                       ),
                       child: IconButton(onPressed: (){
                         final cartItem = CartItem(
                                     id: id,
                                     name: name,
                                     category: category,
                                     image: image,
                                     price: price,
                                     quantity: 1, // Default quantity, modify as needed
                                     description: description
                                   );
                         context.read<CartBloc>().add(AddItemEvent(cartItem));
                         context.read<CartBloc>().add(FetchCartItemsEvent());
                       },
                           icon: Icon(Icons.add),
                         color: Color(0xffF2ECD0),
                       ),
                     )
                   ),
                    // IconButton(
                    //   padding: EdgeInsets.only(left: 35),
                    //     onPressed: () async {
                    //       final cartItem = CartItem(
                    //         id: id,
                    //         name: name,
                    //         image: image,
                    //         price: price,
                    //         quantity: 1, // Default quantity, modify as needed
                    //         description: description
                    //       );
                    //       context.read<CartBloc>().add(AddItemEvent(cartItem));
                    //       // await add.addProductsToFirestore();
                    //     },
                    //     icon: Icon(
                    //       Icons.add_box_rounded,
                    //       color: Colors.blue,
                    //     ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}