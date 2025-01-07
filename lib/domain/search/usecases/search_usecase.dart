import 'package:groceries/data/search/repositories/firebase_search_repository.dart';
import 'package:groceries/data/search/repositories/search_repository.dart';
import 'package:groceries/domain/Home/Models/product.dart';

class SearchUsecase{
  final FirebaseSearchRepository searchRepository;

  SearchUsecase(this.searchRepository);

  Future<List<Grocery>> call (String query){
    return searchRepository.fetchSearchedGroceries(query);
  }
}