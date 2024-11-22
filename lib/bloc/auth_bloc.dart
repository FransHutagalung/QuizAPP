import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/firebase/firebase_auth_service.dart';
import 'package:quiz_app/firebase/firebase_firestore_service.dart';
import 'package:quiz_app/services/user_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignUp>(_onSignUp);
    on<Login>(_onLogin);
  }

  void _onLogin(Login event, Emitter<AuthState> emit)  async {
    Logger logger = Logger();
    Map<String, String> error = {};

    logger
        .d('login received email: ${event.email}, password: ${event.password}');
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(event.email)) {
      logger.d('Email is not valid');
      error['email'] = 'Email is not valid';
    }

    if (event.password.isEmpty || event.password.length < 6) {
      logger.d('Password is not valid');
      error['password'] = 'Password is not valid';
    }

    if (error.isNotEmpty) {
      logger.d(error);
      return emit(AuthError(error));
    }
    try {
      final user = await FirebaseAuthService()
          .signwithemailandpassword(event.email, event.password);
      if (user) {
        return emit(AuthSuccess());
      } else {
        return emit(AuthError(error));
      }
    } catch (e) {
      return emit(AuthError({'err' : e}));
    }
  }

  void _onSignUp(
    SignUp event,
    Emitter<AuthState> emit,
  ) async {
    Logger logger = Logger();
    Map<String, String> error = {};

    logger
        .d('login received email: ${event.email}, password: ${event.password}');
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (!emailRegex.hasMatch(event.email)) {
      logger.d('Email is not valid');
      error['email'] = 'Email is not valid';
    }

    if (event.password.isEmpty || event.password.length < 6) {
      logger.d('Password is not valid');
      error['password'] = 'Password is not valid';
    }

    if (event.name.isEmpty || event.name.length < 2) {
      logger.d('Name is not valid');
      error['name'] = 'Name must not be empty';
    }

    if (error.isNotEmpty) {
      logger.d(error);
      return emit(AuthError(error));
    }

    final user = await FirebaseAuthService()
        .signupwithemailanduser(event.email, event.name, event.password);
    if (user != null) {
      logger.d('User found');
      await FirebaseFirestoreService().addUserToFirestore(user);
      UserService().setUserName(event.name);
      return emit(AuthSuccess());
    } else {
      logger.d('User not found');
    }
  }
}
