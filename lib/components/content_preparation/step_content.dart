import 'package:flutter/material.dart';

class StepContent extends StatelessWidget {
  const StepContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.01,
        width: MediaQuery.of(context).size.width * 0.68,
        child: Row(
          children: [
            Flexible(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2),
                height: MediaQuery.of(context).size.height * 0.01,
                decoration: BoxDecoration(
                  color: Colors.blue ,
                  borderRadius: BorderRadius.circular(5) ,border: Border.all(color: Colors.black.withOpacity(0.9) , width: 1.3)
                ),
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2),
                height: MediaQuery.of(context).size.height * 0.03,
                decoration: BoxDecoration(
                  color: Colors.white ,
                  borderRadius: BorderRadius.circular(5) ,
                  border: Border.all(color: Colors.black.withOpacity(0.9) , width: 1.3)
                ),
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2),
                height: MediaQuery.of(context).size.height * 0.03,
                decoration: BoxDecoration(
                  color: Colors.white ,
                  borderRadius: BorderRadius.circular(5) ,
                  border: Border.all(color: Colors.black.withOpacity(0.9) , width: 1.3)
                ),
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2),
                height: MediaQuery.of(context).size.height * 0.03,
                decoration: BoxDecoration(
                  color: Colors.white ,
                  borderRadius: BorderRadius.circular(5) ,border: Border.all(color: Colors.black.withOpacity(0.9) , width: 1.3)
                ),
              ),
            ),
          ],
        ),
    );
  }
}