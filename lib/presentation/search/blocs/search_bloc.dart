import 'package:bloc/bloc.dart';
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
  }
}
