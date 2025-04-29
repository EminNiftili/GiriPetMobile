import 'package:equatable/equatable.dart';

abstract class PetsEvent extends Equatable {
  const PetsEvent();
}

class LoadPetsRequested extends PetsEvent {
  @override
  List<Object?> get props => [];
}

class LoadMorePetsRequested extends PetsEvent {
  @override
  List<Object?> get props => [];
}
