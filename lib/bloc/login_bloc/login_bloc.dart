import 'package:bloc/bloc.dart';
import 'package:bloc_clean_coding/repository/auth/login_repository.dart';
import 'package:equatable/equatable.dart';

import '../../services/session_manager/session_controller.dart';
import '../../utils/enums.dart';

part 'login_events.dart';

part 'login_states.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(const LoginStates()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginApi>(_loginApi);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginStates> emit) {
    print(event.email);
    emit(
      state.copyWith(
        email: event.email,
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginStates> emit) {
    emit(
      state.copyWith(
        password: event.password,
      ),
    );
  }

  void _loginApi(LoginApi event, Emitter<LoginStates> emit) async {
    Map<String, String> data = {
      'email': 'eve.holt@reqres.in',
      'password': 'cityslicka',
    };
    // Map<String, String> data = {
    //   'email': state.email,
    //   'password': state.password,
    // };

    emit(state.copyWith(
      postApiStatus: PostApiStatus.loading,
    ));

    await loginRepository.loginApi(data).then((value) async {
      if (value.error.isNotEmpty) {

        // emit(state.copyWith(
        //     message: value.error.toString(),
        //     postApiStatus: PostApiStatus.error));

        emit(
          state.copyWith(
            message: value.token,
            postApiStatus: PostApiStatus.success,
          ),
        );
      } else {

        await SessionController().saveUserInPreference(value);
        await SessionController().getUserFromPreference();

        // emit(
        //   state.copyWith(
        //     message: value.token,
        //     postApiStatus: PostApiStatus.success,
        //   ),
        // );

        emit(state.copyWith(
            message: value.error.toString(),
            postApiStatus: PostApiStatus.error));
      }
    }).onError((error, stackTrace) {
      emit(
        state.copyWith(
            message: error.toString(), postApiStatus: PostApiStatus.error),
      );
    });
  }
}
