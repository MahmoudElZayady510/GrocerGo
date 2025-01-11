import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:groceries/domain/Home/Models/product.dart';
import 'package:groceries/domain/search/usecases/search_usecase.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  final SearchUsecase searchUsecase;
  SearchBloc(this.searchUsecase) : super(SearchInitial()) {
    on<FetchSearch>((event, emit) async {
      emit(SearchLoading());
      try {
        final groceries = await searchUsecase.call(event.query);
        print(groceries);
        emit(SearchLoaded(groceries));
      } catch (e) {
        emit(SearchFailed(e.toString()));
      }
    });
    on<SearchResetEvent>((event, emit) async {
      emit(SearchInitial());
    });
    on<SearchSort>((event, emit) {
      final String sortOptions = event.sortOptions;
      // final String filterCategory = event.filterCategory;
      if (state is SearchLoaded){
        List<Grocery> results = (state as SearchLoaded).groceries;
        // emit(SearchLoading());
        switch (sortOptions) {
          case 'aToz':
            results.sort((a, b) => a.name.compareTo(b.name));
            print('sorted');
            break;
          case 'priceLowToHigh':
            results.sort((a, b) => a.price.compareTo(b.price));
            print('sorted');
          break;
          case 'priceHighToLow':
            results.sort((a, b) => b.price.compareTo(a.price));
            print('sorted');
            break;
        }
        // switch (filterCategory){
        //   case 'Fruits':
        //     print('printed');
        //     results = results.where((grocery) => grocery.category == filterCategory).toList();
        //     break;
        // }
        print('notSorted');
        emit(SearchLoaded(results));
      }
    });
  }
}
