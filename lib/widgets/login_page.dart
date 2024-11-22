import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/bloc/auth_bloc.dart';
import 'package:quiz_app/components/ball.dart';
import 'package:quiz_app/components/button_form_1.dart';
import 'package:quiz_app/components/error_label.dart';
import 'package:quiz_app/components/text_field_label.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Logger _logger = Logger();

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  void login(BuildContext context) async {
    setState(() {
      loadingLogin = true;
    });
    _logger.d('Login');
    context
        .read<AuthBloc>()
        .add(Login(controllerEmail.text, controllerPassword.text));
    
  }

  Future<void> waiting(int time) async {
    await Future.delayed(Duration(milliseconds: time));
    loadingLogin = true;
  }

  void login_width_google() async {
    //  User? user = await FirebaseAuthService().googlesignin();
  }

  String emailError = '';
  String passwordError = '';
  String loginError = '';
  bool loadingLogin = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          print('there is error');
          setState(() {
            if (state.error['email'] == "Email is not valid") {
              emailError = state.error['email'];
              // ScaffoldMessenger.of(context)
              //     .showSnackBar(SnackBar(content: Text(state.error['email'])));
            } else {
              emailError = '';
            }

            if (state.error['password'] == 'Password is not valid') {
              passwordError = state.error['password'];
            } else {
              passwordError = '';
            }

            if (state.error['err'] != null) {
              loginError = state.error['err'];
            } else {
              loginError = '';
            }
            loadingLogin = false;
          });
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
              // alignment: Alignment.center,
              children: <Widget>[
                Ball(),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.06,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.03,
                        right: MediaQuery.of(context).size.width * 0.03),
                    width: MediaQuery.of(context).size.width * 0.94,
                    height: MediaQuery.of(context).size.height * 0.56,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        border: Border.all(color: Colors.grey.withAlpha(100)),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        )),
                    child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Welcome Back ",
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          TextFieldLabel(
                            isError: emailError.isNotEmpty,
                            Error: emailError,
                            label: "email",
                            controller: controllerEmail,
                            icon: const Icon(Icons.email),
                          ),
                          // const SizedBox(height: 1),
                          TextFieldLabel(
                            Error: passwordError,
                            isError: passwordError.isNotEmpty,
                            label: "password",
                            controller: controllerPassword,
                            icon: const Icon(Icons.lock),
                          ),
                          const SizedBox(height: 3),
                          ErrorLabel(
                              error: loginError,
                              isShown: loginError.isNotEmpty),
                          const SizedBox(height: 15),
                          ButtonForm1(
                              isLoading: loadingLogin,
                              callbackAction: () => login(context),
                              text: "Login",
                              islogo: false,
                              color: Colors.green),
                          const SizedBox(height: 10),
                          ButtonForm1(
                              callbackAction: login_width_google,
                              text: "Google",
                              logo: 'assets/icons/googlelogo.png',
                              color: Colors.blue,
                              islogo: true),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10, top: 5, right: 5, bottom: 10),
                            child: Row(children: [
                              Text('Don\'t have an account?'),
                              TextButton(
                                child: Text('Sign Up'),
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.blue),
                                onPressed: () {
                                  context.goNamed('signup');
                                },
                              )
                            ]),
                          )
                        ]),
                  ),
                ),
              ])),
    );
  }
}
