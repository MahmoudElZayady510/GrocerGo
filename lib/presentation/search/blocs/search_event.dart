part of 'search_bloc.dart';


abstract class SearchEvent {}
class FetchSearch implements SearchEvent{
  final String query;

  FetchSearch(this.query);
}
class SearchResetEvent implements SearchEvent{}
class SearchSort implements SearchEvent{
  final String sortOptions;
  // final String filterCategory;

  SearchSort({required this.sortOptions ,});

}
