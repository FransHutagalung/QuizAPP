import 'package:flutter/material.dart';

class TextFieldLabel extends StatefulWidget {
  final String label;
  final Icon icon;
  final TextEditingController controller;
  String? Error;
  final bool isError;
  TextFieldLabel(
      {super.key,
      required this.label,
      required this.controller,
      required this.icon,
      this.Error,
      required this.isError});

  @override
  State<TextFieldLabel> createState() => _TextFieldLabelState();
}

class _TextFieldLabelState extends State<TextFieldLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 2, right: 5, bottom: 2),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 85,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.label),
            SizedBox(
              width: 10,
            ),
            Container(
              child: widget.isError
                  ? Row(
                      children: [
                        Icon(
                          Icons.dangerous,
                          color: Colors.red,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(widget.Error!,
                            style: TextStyle(color: Colors.red, fontSize: 13)),
                      ],
                    )
                  : null,
            )
          ],
        ),
        SizedBox(
          height: 2,
        ),
        Expanded(
          // child: Container(
          child: TextField(
              decoration: InputDecoration(
                  prefixIcon: widget.icon,
                  filled: false,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 3 , 
                    vertical: 2
                  ),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2))
                  //  fillColor: Colors.white
                  ),
              controller: widget.controller),
        ),
        // ),
        // )
      ]),
    );
  }
}
