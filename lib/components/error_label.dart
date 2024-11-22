import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorLabel extends StatefulWidget {
  final String error ;
  final bool isShown ; 
  const ErrorLabel({super.key, required this.error, required this.isShown});

  @override
  State<ErrorLabel> createState() => _ErrorLabelState();
}

class _ErrorLabelState extends State<ErrorLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: 3
      ),
      child: widget.isShown ? Center(child: Text(widget.error , style: TextStyle(color: Colors.red),)) : null
    );
  }
}