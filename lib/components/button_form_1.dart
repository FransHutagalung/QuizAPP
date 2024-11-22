import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonForm1 extends StatefulWidget {
  final VoidCallback callbackAction;
  final Color color;
  final String text;
  String? logo;
  final bool islogo;
  bool isLoading;

  ButtonForm1({
    super.key,
    required this.callbackAction,
    required this.text,
    this.logo,
    this.isLoading = false,
    required this.color,
    required this.islogo,
  });

  @override
  State<ButtonForm1> createState() => _ButtonForm1State();
}

class _ButtonForm1State extends State<ButtonForm1>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;

  void _handleTap() async {
    setState(() {
      _opacity = 1.0; // Menambah opacity untuk efek
    });

    await Future.delayed(const Duration(milliseconds: 500), () {
      widget.callbackAction();
      setState(() {
        _opacity = 0.0; // Reset animasi setelah selesai
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.88,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: widget.color,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.isLoading
                    ?  Container(
                        child: Image.asset("assets/icons/loading1.gif"),
                      )
                    : Text(
                        widget.text,
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                const SizedBox(width: 10),
                if (widget.islogo)
                  SizedBox(
                    height: 30,
                    child: Image.asset(widget.logo!),
                  ),
              ],
            ),
          ),
          AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(milliseconds: 500),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.88,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.3), // Efek opacity
              ),
            ),
          ),
        ],
      ),
    );
  }
}
