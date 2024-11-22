import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class ContentPreparation extends StatefulWidget {
  const ContentPreparation({super.key});

  @override
  State<ContentPreparation> createState() => _ContentPreparationState();
}

class _ContentPreparationState extends State<ContentPreparation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        child:  InkWell(
           onTap: ()  {
             context.goNamed('content1');
           },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Next ',
                style: GoogleFonts.roboto(fontSize: 20, color: Colors.white),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
              )
            ],
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
          color: Colors.green
        ),
      ),
      body: SafeArea(
      
        child: Padding(
          padding:  EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.08,
            right: MediaQuery.of(context).size.width * 0.08,
            // bottom: MediaQuery.of(context).size.height * 0.1 , 
            top: MediaQuery.of(context).size.height * 0.1
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Let us know your information so we can prepare the content for you', 
                style: GoogleFonts.roboto(fontSize: 24, color: Colors.black)
                ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                child: Image.asset(
                  'assets/images/teacher.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        )
        ),
    );
  }
}