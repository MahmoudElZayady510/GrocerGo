part of 'search_bloc.dart';

class SearchState {}

final class SearchInitial extends SearchState {}
final class SearchLoading extends SearchState {}
final class SearchLoaded extends SearchState {
  final List<Grocery> groceries;

  SearchLoaded(this.groceries);
}

final class SearchFailed extends SearchState {
  final String error;

  SearchFailed(this.error);

}
