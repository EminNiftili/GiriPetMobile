import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giripet_mobile/data/datasources/user_datasource.dart';
import 'package:giripet_mobile/data/models/user.dart';
import 'edit_profile_event.dart';
import 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  late UserDataSource _userDataSource;
  User? user;

  EditProfileBloc() : super(EditProfileState.initial()) {
    _userDataSource = UserDataSource();

    on<ProfileInfoChanged>((event, emit) {
      if(event.fullName != null){
        emit(state.copyWith(name: event.fullName));
      }
      else if(event.phoneNumber != null){
        emit(state.copyWith(phone: event.phoneNumber));
      }
    });

    on<EditActionEvent>(_onEditAction);

    on<LoadProfileRequested>(_onLoadProfileRequested);

    on<ToggleEditing>((event, emit) {
      emit(state.copyWith(isEditing: !state.isEditing));
    });
  }

  Future<void> _onEditAction(
      EditActionEvent event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(isLoading: true));

    if (user != null) {
      var isSuccess = await _userDataSource.update(
          id: user!.id, fullName: state.name, phone: state.phone);
      if (isSuccess) {
        emit(state.copyWith(isFailure: false, isSuccess: true));
      } else {
        emit(state.copyWith(isFailure: true, isSuccess: false));
      }
    } else {
      emit(state.copyWith(isFailure: true, isSuccess: false));
    }
  }

  Future<void> _onLoadProfileRequested(
    LoadProfileRequested event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    user = await _userDataSource.me();

    if (user != null) {
      emit(state.copyWith(
        name: user!.fullName,
        email: user!.email,
        phone: user!.phoneNumber,
        isLoading: false,
      ));
    }
  }
}
