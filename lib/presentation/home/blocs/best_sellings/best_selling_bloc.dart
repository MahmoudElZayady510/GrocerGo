import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/Home/Models/product.dart';
import '../../../../domain/Home/usecases/fetch_bestSelling_usecase.dart';

part 'best_selling_event.dart';
part 'best_selling_state.dart';

class BestSellingBloc extends Bloc<BestSellingEvent, BestSellingState> {
  final FetchBestsellingUsecase fetchBestselling;
  BestSellingBloc(this.fetchBestselling) : super(BestSellingLoading()) {
    on<FetchBestSellingList>((event, emit) async {

      emit(BestSellingLoading());

      await emit.forEach<List<Grocery>>(
        fetchBestselling(),
        onData: (groceries) => BestSellingLoaded(groceries),
        onError: (error, stackTrace) => BestSellingError(error.toString()),
      );
    });
  }
}
