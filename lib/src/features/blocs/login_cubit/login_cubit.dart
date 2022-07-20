import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:models/models.dart';
import 'package:user_repository/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  LoginCubit(
      {required AuthenticationRepository authenticationRepository,
      required UserRepository userRepository})
      : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(LoginState());

  void changeUsername(
    Username username,
  ) {
    emit(state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    ));
  }

  void changePassword(
    Password password,
  ) {
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    ));
  }

  void submit() async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      User? user = await _authenticationRepository.logIn(
          username: state.username.value, password: state.password.value);
      if (user != null) {
        _userRepository.setUser(user);
        _authenticationRepository.authenticate();
        return emit(state.copyWith(status: FormzStatus.submissionSuccess));
      }
      return emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
