import 'package:bloc/bloc.dart';
import 'package:groceries/domain/Home/usecases/fetch_products_by_category.dart';
import 'package:meta/meta.dart';

import '../../../domain/Home/Models/product.dart';

part 'similar_products_event.dart';
part 'similar_products_state.dart';

class SimilarProductsBloc extends Bloc<SimilarProductsEvent, SimilarProductsState> {
  final FetchGroceriesByCategoryUsecase fetchGroceriesByCategoryUsecase;
  SimilarProductsBloc(this.fetchGroceriesByCategoryUsecase) : super(SimilarProductsLoading()) {
    on<FetchSimilarProducts>((event, emit) async {
      emit(SimilarProductsLoading());
      await emit.forEach<List<Grocery>>(
        fetchGroceriesByCategoryUsecase(event.category),
        onData: (groceries) => SimilarProductsLoaded(groceries),
        onError: (error, stackTrace) => SimilarProductsError(error.toString()),
      );
    });
  }
}
