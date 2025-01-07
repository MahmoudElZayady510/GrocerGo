import 'package:bloc/bloc.dart';
import 'package:groceries/domain/Home/usecases/fetch_products_by_category.dart';
import 'package:meta/meta.dart';


import '../../../domain/Home/Models/product.dart';
import '../../../domain/Home/usecases/fetch_products_usecase.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {

  final FetchGroceriesUsecase fetchGroceries;
  final FetchGroceriesByCategoryUsecase fetchGroceriesByCategory;
  ProductsBloc(this.fetchGroceries, this.fetchGroceriesByCategory) : super(ProductsLoading()) {
    on<FetchGroceryList>((event, emit) async {

      emit(ProductsLoading());

      await emit.forEach<List<Grocery>>(
        fetchGroceries(),
        onData: (groceries) => ProductsLoaded(groceries),
        onError: (error, stackTrace) => ProductsError(error.toString()),
      );
    });
    on<FetchGroceryListByCategory>((event, emit) async {
      emit(ProductsLoading());
      // final groceriesStream = await fetchGroceriesByCategory(event.category);
      // final groceries = await groceriesStream.first;
      // emit(ProductsLoaded(groceries));
      ///////////////////////////////|||\\\\\\\\\\\\\\\\\\\\
      await emit.forEach<List<Grocery>>(
        fetchGroceriesByCategory(event.category),
        onData: (groceries) => ProductsLoaded(groceries),
        onError: (error, stackTrace) => ProductsError(error.toString()),
      );
    });
    }
  }

