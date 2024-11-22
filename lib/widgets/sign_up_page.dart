import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/bloc/auth_bloc.dart';
import 'package:quiz_app/components/ball.dart';
import 'package:quiz_app/components/button_form_1.dart';
import 'package:quiz_app/components/text_field_label.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final Logger _logger = Logger();

  TextEditingController controlleremail = TextEditingController();
  TextEditingController controllerpassword = TextEditingController();
  TextEditingController controllername = TextEditingController();
  void login() async {
    _logger.d('Login');
  }

  void signUpWithGoogle() async {
    //  User? user = await FirebaseAuthService().googlesignin();
  }

  void signUp(BuildContext context) async {
    context.read<AuthBloc>().add(SignUp(
        controllername.text, controlleremail.text, controllerpassword.text));
  }

  String emailError = '';
  String passwordError = '';
  String nameError = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          _logger.d('there is error');
          setState(() {
            if (state.error['email'] == "Email is not valid") {
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error['email'])));
              _logger.d('Email is not valid');
              emailError = state.error['email'];
            } else {
              emailError = '';
            }

            if (state.error['name'] == "Name must not be empty") {
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error['name'])));
              _logger.d('Name must not be empty');
              nameError = state.error['name'];
            } else {
              nameError = '';
            }

            if (state.error['password'] == 'Password is not valid') {
              _logger.d('Password is not valid');
              passwordError = state.error['password'];
            } else {
              passwordError = '';
            }
          });
        }

        if (state is AuthSuccess) {
          _logger.d('success');
          context.goNamed('homepage');
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
              // alignment: Alignment.center,
              children: <Widget>[
                Ball(),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.05,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.03,
                        right: MediaQuery.of(context).size.width * 0.03),
                    width: MediaQuery.of(context).size.width * 0.94,
                    height: MediaQuery.of(context).size.height * 0.68,
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
                            "Join With Us",
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 40),
                          TextFieldLabel(
                            isError: nameError.isNotEmpty,
                            Error: nameError,
                            label: "name",
                            controller: controllername,
                            icon: const Icon(Icons.people),
                          ),
                          const SizedBox(height: 2),
                          TextFieldLabel(
                            isError: emailError.isNotEmpty,
                            Error: emailError,
                            label: "email",
                            controller: controlleremail,
                            icon: const Icon(Icons.email),
                          ),
                          const SizedBox(height: 2),
                          TextFieldLabel(
                            isError: passwordError.isNotEmpty,
                            Error: passwordError,
                            label: "password",
                            controller: controllerpassword,
                            icon: const Icon(Icons.lock),
                          ),
                          const SizedBox(height: 15),
                          ButtonForm1(
                              callbackAction: () => signUp(context),
                              text: "Sign Up",
                              islogo: false,
                              color: Colors.green),
                          const SizedBox(height: 10),
                          ButtonForm1(
                              callbackAction: () => signUp,
                              text: "Google",
                              logo: 'assets/icons/googlelogo.png',
                              color: Colors.blue,
                              islogo: true),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 5, right: 5, bottom: 10),
                            child: Row(children: [
                              const Text('already have an account?'),
                              TextButton(
                                child:  Text('Login'),
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.blue),
                                onPressed: () {
                                  context.goNamed('login');
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
