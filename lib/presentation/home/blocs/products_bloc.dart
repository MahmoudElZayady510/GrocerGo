import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/Home/repositories/product.dart';
import '../../../domain/Home/Models/product.dart';
import '../../../domain/Home/usecases/fetch_products_usecase.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {

  final FetchGroceries fetchGroceries;
  ProductsBloc(this.fetchGroceries) : super(ProductsLoading()) {
    on<FetchGroceryList>((event, emit) async {
      print('loading');
      emit(ProductsLoading());

      await emit.forEach<List<Grocery>>(
        fetchGroceries(),
        onData: (groceries) => ProductsLoaded(groceries),
        onError: (error, stackTrace) => ProductsError(error.toString()),
      );
    });
    }
  }

