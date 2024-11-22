part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthError extends AuthState{
  final Map<String, dynamic> error;
   AuthError(this.error);
}



final class AuthSuccess extends AuthState {
  
}