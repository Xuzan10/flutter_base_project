import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mcn_app/models/user.dart';
import 'package:mcn_app/repository/login_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  LoginRepository loginRepository;

  AuthenticationCubit(this.loginRepository)
      : super(AuthenticationInitialState());

  loginUser(String email, String password) async {
    emit(AuthenticationLoadingState());
    try {
      var user = await loginRepository.login(email, password);
      emit(AuthenticationSuccessState(user));
    } catch (e) {
      print(e.toString());
      emit(AuthenticationErrorState(e.toString()));
    }
  }

  isLoggedIn() {
    emit(AuthenticationLoadingState());
    User? user = loginRepository.isLoggedIn();
    if (user == null) {
      emit(AuthenticationFailedState());
      return;
    }
    emit(AuthenticationSuccessState(user));
  }
}
