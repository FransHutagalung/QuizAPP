import 'package:flutter/material.dart';

class AppProgress extends StatelessWidget {
  const AppProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body : Column(
        children: [
          Text(
            'app in progress'
          )
        ],
      )
    );
  }
}