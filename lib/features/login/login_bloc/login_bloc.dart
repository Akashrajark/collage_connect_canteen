import 'package:bloc/bloc.dart';
import 'package:college_connect_canteen/values/strings.dart';
import 'package:logger/web.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      try {
        emit(LoginLoadingState());
        AuthResponse authResponse =
            await Supabase.instance.client.auth.signInWithPassword(
          password: event.password,
          email: event.email,
        );
        emit(LoginSuccessState());
      } catch (e, s) {
        Logger().e('$e\n$s');

        if (e is AuthException) {
          emit(LoginFailureState(message: e.message));
        } else {
          emit(LoginFailureState());
        }
      }
    });
  }
}
