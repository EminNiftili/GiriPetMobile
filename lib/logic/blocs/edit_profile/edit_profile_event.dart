import 'package:equatable/equatable.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();
}

class ProfileInfoChanged extends EditProfileEvent {
  String? fullName;
  String? phoneNumber;

  ProfileInfoChanged(this.fullName, this.phoneNumber);

  @override
  List<Object?> get props => [fullName, phoneNumber];
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
