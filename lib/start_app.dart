import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/auth_bloc.dart';
import 'package:quiz_app/bloc/content_preparation_bloc.dart';
import 'package:quiz_app/routes/routes.dart';
// import 'package:shimmer/main.dart';

class StartApp extends StatelessWidget {
  const StartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
        BlocProvider<ContentPreparationBloc>(create: (_) => ContentPreparationBloc())
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Quiz App',
        routerConfig: router,
      ),
    );
  }
}
