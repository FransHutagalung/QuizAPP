import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/services/shared_pref.dart';
import 'package:quiz_app/widgets/app/homepage.dart';
import 'package:quiz_app/widgets/app_progress.dart';
import 'package:quiz_app/widgets/body.dart';
import 'package:quiz_app/widgets/content_preparation.dart';
import 'package:quiz_app/widgets/content_preparation/content_1.dart';
import 'package:quiz_app/widgets/content_preparation/content_2.dart';
import 'package:quiz_app/widgets/login_page.dart';
import 'package:quiz_app/widgets/sign_up_page.dart';

final GoRouter router  = GoRouter(
   initialLocation:  '/' ,
   routes: <RouteBase>[
     GoRoute(
      path:  '/' , 
      name : 'homepage' ,
      builder: (BuildContext context, GoRouterState state)  {
         return  StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, authSnapshot) {
            if (authSnapshot.connectionState == ConnectionState.waiting) {
              return const AppProgress();
            }
            if (authSnapshot.hasData &&
                FirebaseAuth.instance.currentUser != null) {
                return FutureBuilder(
                  future: SharedPref().get_status_onboarding(), 
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      if(snapshot.data == true) {
                        return const Body();
                      } else {
                        return const ContentPreparation();
                      }
                    }
                    return const AppProgress();
                  }
                  );
            } else {
              return const LoginPage(); // Tampilkan halaman login
            }
          },
        );
      },
     ) ,
     GoRoute(
       path : '/login' ,
       name : 'login' ,
       builder: (BuildContext context ,GoRouterState state) => const LoginPage()
     ) ,
     GoRoute(
       path : '/signup' ,
       name : 'signup' ,
       builder: (BuildContext context ,GoRouterState state) => const SignUpPage()
     ) ,
     GoRoute(
      path :'/contentpreparation' , 
      name : 'contentpreparation' , 
      builder: (BuildContext context ,GoRouterState state) => const ContentPreparation()
     ) ,
     GoRoute(
      path :'/content1' , 
      name : 'content1' , 
      builder: (BuildContext context ,GoRouterState state) => const Content1()
     ) ,
     GoRoute(
      path :'/content2' , 
      name : 'content2' , 
      builder: (BuildContext context ,GoRouterState state) => const Content2()
     ) ,
   ]
);