import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/bloc/content_preparation_bloc.dart';
import 'package:quiz_app/components/content_preparation/button_1.dart';
import 'package:quiz_app/components/content_preparation/step_content.dart';
import 'package:quiz_app/widgets/content_preparation.dart';

class Content1 extends StatefulWidget {
  const Content1({super.key});

  @override
  State<Content1> createState() => _Content1State();
}

class _Content1State extends State<Content1> {
  final Logger _logger = Logger();

  bool age1 = false;
  bool age2 = false;
  bool age3 = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContentPreparationBloc, ContentPreparationState>(
      listener: (context, state) {
        setState(() {});

        if (state is AgePicker) {
          switch (state.age) {
            case 1:
              _logger.d('age 10-15');
              age1 = true;
              age2 = false;
              age3 = false;
              break;

            case 2:
              _logger.d('age 16-20');
              age1 = false;
              age2 = true;
              age3 = false;
              break;

            case 3:
              _logger.d('age 21-26');
              age1 = false;
              age2 = false;
              age3 = true;
              break;

            default:
              _logger.d('Unknown age group');
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const StepContent(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Text(
                  'How Old Are You ?',
                  style: GoogleFonts.roboto(fontSize: 20, color: Colors.black),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.27,
                ),
                Center(
                    child: Button1(
                  iconImage: 'assets/icons/children.png',
                  ageText: '10-15',
                  isActive: age1,
                  age: 1,
                )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Center(
                    child: Button1(
                  iconImage: 'assets/icons/teenager.png',
                  ageText: '16-20',
                  isActive: age2,
                  age: 2,
                )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Center(
                    child: Button1(
                  iconImage: 'assets/icons/adult.png',
                  ageText: '21-27',
                  isActive: age3,
                  age: 3,
                )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                )
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          padding: EdgeInsets.only(right: 10),
          height: MediaQuery.of(context).size.height * 0.07,
          color: Colors.white,
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Next',
                style: TextStyle(color: Colors.blue),
              ),
              Icon(Icons.keyboard_arrow_right, color: Colors.blue)
            ],
          ),
        ),
      ),
    );
  }
}
