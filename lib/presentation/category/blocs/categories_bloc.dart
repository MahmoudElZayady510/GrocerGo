import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:groceries/domain/category/models/category.dart';
import 'package:groceries/domain/category/usecases/fetch_categories_usecase.dart';
import 'package:meta/meta.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final FetchCategories fetchCategories;
  CategoriesBloc(this.fetchCategories) : super(CategoriesLoading()) {
    on<FetchCategoryList>((event, emit) async {
      emit(CategoriesLoading());
      await emit.forEach<List<CategoryModel>>(
        fetchCategories(),
        onData: (categories) => CategoriesLoaded(categories , ''),
        onError: (error, stackTrace) => CategoriesError(error.toString())
      );
    });
    on<SelectCategory>((event, emit) async {
      if (state is CategoriesLoaded){
        final categories = (state as CategoriesLoaded).categories;
        emit(CategoriesLoaded(categories, event.currentCategory));
      }
    });
  }
}
