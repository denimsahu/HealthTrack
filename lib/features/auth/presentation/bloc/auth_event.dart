part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthSignupEvent extends AuthEvent{
  String email;
  String password;
  String fullName;
  String phoneNumber;
  AuthSignupEvent({required this.email, required this.password, required this.fullName, required this.phoneNumber}); 
}

class AuthLoginEvent extends AuthEvent{
  String email;
  String password;
  AuthLoginEvent({required this.email, required this.password});
}

class AuthLogoutEvent extends AuthEvent{

}
