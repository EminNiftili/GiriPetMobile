import 'package:equatable/equatable.dart';

class Pet {
  final String id;
  final String name;
  final String breed;

  Pet({required this.id, required this.name, required this.breed});
}

class PetsState extends Equatable {
  final List<Pet> pets;
  final bool isLoading;
  final bool hasReachedMax;

  const PetsState({
    required this.pets,
    required this.isLoading,
    required this.hasReachedMax,
  });

  factory PetsState.initial() => const PetsState(
        pets: [],
        isLoading: false,
        hasReachedMax: false,
      );

  PetsState copyWith({
    List<Pet>? pets,
    bool? isLoading,
    bool? hasReachedMax,
  }) {
    return PetsState(
      pets: pets ?? this.pets,
      isLoading: isLoading ?? this.isLoading,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [pets, isLoading, hasReachedMax];
}
