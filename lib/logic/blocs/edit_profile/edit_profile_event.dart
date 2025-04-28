import 'package:equatable/equatable.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();
}

class ToggleEditing extends EditProfileEvent {
  @override
  List<Object?> get props => [];
}

class LoadProfileRequested extends EditProfileEvent {
  @override
  List<Object?> get props => [];
}

class EditActionEvent extends EditProfileEvent {
  @override
  List<Object?> get props => [];
}
