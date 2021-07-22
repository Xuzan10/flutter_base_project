part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationSuccessState extends AuthenticationState {
  final User user;

  AuthenticationSuccessState(this.user);

  @override
  List<Object> get props => [user];
}

class AuthenticationFailedState extends AuthenticationState {}


class AuthenticationErrorState extends AuthenticationState {
  final error;

  AuthenticationErrorState(this.error);

  @override
  List<Object> get props => [error];
}
