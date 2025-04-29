import 'package:flutter_bloc/flutter_bloc.dart';
import 'pets_event.dart';
import 'pets_state.dart';

class PetsBloc extends Bloc<PetsEvent, PetsState> {
  PetsBloc() : super(PetsState.initial()) {
    on<LoadPetsRequested>(_onLoadPetsRequested);
    on<LoadMorePetsRequested>(_onLoadMorePetsRequested);
  }

  Future<void> _onLoadPetsRequested(
    LoadPetsRequested event,
    Emitter<PetsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 1)); // fake loading

    final loadedPets = List.generate(
      10,
      (index) => Pet(
        id: 'id_$index',
        name: 'Pet $index',
        breed: 'Breed $index',
      ),
    );

    emit(state.copyWith(
      isLoading: false,
      pets: loadedPets,
      hasReachedMax: false,
    ));
  }

  Future<void> _onLoadMorePetsRequested(
    LoadMorePetsRequested event,
    Emitter<PetsState> emit,
  ) async {
    if (state.hasReachedMax || state.isLoading) return;

    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 1)); // fake loading

    final morePets = List.generate(
      10,
      (index) => Pet(
        id: 'id_${state.pets.length + index}',
        name: 'Pet ${state.pets.length + index}',
        breed: 'Breed ${state.pets.length + index}',
      ),
    );

    emit(state.copyWith(
      isLoading: false,
      pets: List.of(state.pets)..addAll(morePets),
      hasReachedMax: morePets.isEmpty,
    ));
  }
}
