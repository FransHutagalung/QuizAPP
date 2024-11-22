import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/bloc/content_preparation_bloc.dart';

class Button1 extends StatefulWidget {
  final String iconImage ;
  final String ageText ;
  final bool isActive ;
  final int age ;
  const Button1({super.key, required this.iconImage, required this.ageText, required this.isActive , required this.age});

  @override
  State<Button1> createState() => _Button1State();
}

class _Button1State extends State<Button1> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          
        });
        BlocProvider.of<ContentPreparationBloc>(context).add(SetAge(widget.age));
      },
      child: Container(
         width: MediaQuery.of(context).size.width * 0.88,
         height: 70,
         child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(widget.iconImage , height: 50,),
            SizedBox(
              width: 10,
            ) ,
            Text(
              widget.ageText ,
              style: GoogleFonts.roboto(fontSize: 20, color: Colors.white),
              )
          ],
         ),
         decoration: BoxDecoration(
          border: widget.isActive ? Border.all(
            color: Colors.black ,
            width: 3
          ) : null,
          color : Colors.blue , 
          borderRadius: BorderRadius.circular(10)
         ),
      ),
    );
  }
}