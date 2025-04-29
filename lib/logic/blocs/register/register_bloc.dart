import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giripet_mobile/core/constants/shared_preference_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:giripet_mobile/data/datasources/auth_remote_datasource.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRemoteDataSource authRemote = AuthRemoteDataSource();

  RegisterBloc() : super(RegisterState.initial()) {
    on<RegisterNameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<RegisterEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<RegisterPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<RegisterConfirmPasswordChanged>((event, emit) {
      emit(state.copyWith(confirmPassword: event.confirmPassword));
    });

    on<RegisterPhoneChanged>((event, emit) {
      emit(state.copyWith(phone: event.phone));
    });

    on<RegisterSubmitted>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      emit(state.copyWith(
          isSubmitting: true, isFailure: false, isSuccess: false));

      if (state.password.isEmpty || state.password != state.confirmPassword) {
        emit(state.copyWith(
            isSubmitting: false,
            isSuccess: false,
            isFailure: true,
            errorMessage: 'Password does not match'));
        emit(state.copyWith(isLoading: false));
        return;
      }

      try {
        final token = await authRemote.register(
            name: state.name,
            email: state.email,
            password: state.password,
            phone: state.phone);
        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(SharedPreferenceKeys.token, token);
          emit(state.copyWith(
            isSubmitting: false,
            isSuccess: true,
            isFailure: false,
            isLoading: false,
          ));
        } else {
          emit(state.copyWith(
            isSubmitting: false,
            isSuccess: false,
            isFailure: true,
            isLoading: false,
          ));
        }
      } catch (e) {
        emit(state.copyWith(
            isLoading: false,
            isSubmitting: false,
            isFailure: true,
            isSuccess: false,
            errorMessage: 'Something went wrong'));
        emit(state.copyWith(isLoading: false));
      }
    });
  }
}
