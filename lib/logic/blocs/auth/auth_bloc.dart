import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giripet_mobile/core/constants/shared_preference_keys.dart';
import 'package:giripet_mobile/data/datasources/auth_remote_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late AuthRemoteDataSource _authRemoteDataSource;
  AuthBloc() : super(AuthState.initial()) {
    _authRemoteDataSource = AuthRemoteDataSource();

    on<AuthEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<AuthPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<AuthSubmitted>((event, emit) async {
      emit(state.copyWith(
          isSubmitting: true, isFailure: false, isSuccess: false));
      await Future.delayed(const Duration(seconds: 1));
      var token = await _authRemoteDataSource.login(
          email: state.email, password: state.password);
      if (token != null && token.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(SharedPreferenceKeys.token, token);
        emit(state.copyWith(
            isSubmitting: false, isSuccess: true, isFailure: false));
      } else {
        emit(state.copyWith(isSubmitting: false, isFailure: true));
      }
    });
  }
}
