import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/firebase/firebase_notifications.dart';
import 'package:quiz_app/start_app.dart';
import 'package:quiz_app/components/ball.dart';
import 'package:shimmer/main.dart';
import 'package:quiz_app/bloc/app_bloc_observer.dart';

void main() async{
  final logger = Logger();
  WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Transparan
      ),
  );
   try{
    await Firebase.initializeApp();
    await FirebaseNotifications().initNotifications();
    logger.d("firebase init");
  }catch(e){
    logger.d(e);
  }
  Bloc.observer = AppBlocObserver();
  runApp(StartApp());
}

