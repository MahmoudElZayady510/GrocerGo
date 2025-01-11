import 'package:bloc/bloc.dart';
import 'package:groceries/domain/Home/usecases/fetch_newArrival_usecase.dart';
import 'package:meta/meta.dart';

import '../../../../domain/Home/Models/product.dart';

part 'new_arrival_event.dart';
part 'new_arrival_state.dart';

class NewArrivalBloc extends Bloc<NewArrivalEvent, NewArrivalState> {
  final FetchNewArrivalUsecase fetchNewArrivalUsecase;
  NewArrivalBloc(this.fetchNewArrivalUsecase) : super(NewArrivalLoading()) {
    on<NewArrivalEvent>((event, emit) async {
      emit(NewArrivalLoading());

      await emit.forEach<List<Grocery>>(
        fetchNewArrivalUsecase(),
        onData: (groceries) => NewArrivalLoaded(groceries),
        onError: (error, stackTrace) => NewArrivalError(error.toString()),
      );
    });
  }
}
