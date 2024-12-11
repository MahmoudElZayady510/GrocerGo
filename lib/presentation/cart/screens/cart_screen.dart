import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            print('fetching');
            context.read<CartBloc>().add(
              FetchCartItemsEvent(),
            );
            return Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            return ListView.builder(
              itemCount: state.cartItems.length,
              itemBuilder: (context, index) {
                final item = state.cartItems[index];

                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('Price: \$${item.price}'),
                  trailing: Text('Qty: ${item.quantity}'),
                );
              },
            );
          }else {
            return Center(child: Text('Cart is empty.'));
          }
        },
      ),
    );
  }
}
