import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/Home/repositories/product.dart';
import '../blocs/products_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Groceries')),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            context.read<ProductsBloc>().add(
              FetchGroceryList(),
            );
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductsLoaded) {
            return ListView.builder(
              itemCount: state.groceries.length,
              itemBuilder: (context, index) {
                final item = state.groceries[index];
                print(item);
                return GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/details',
                      arguments: {
                        'id' :item.id,
                        'name' : item.name,
                        'image' : item.image,
                        'description': item.description
                      }
                    );
                  },
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text('\$${item.price}'),
                    leading: Image.network(item.image),
                  ),
                );
              },
            );
          } else if (state is ProductsError) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return Center(child: Text('Unknown state'));
        },
      )
    );
  }
}
