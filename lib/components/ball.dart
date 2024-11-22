import 'dart:ui';
import 'package:flutter/material.dart';

class Ball extends StatefulWidget {
  @override
  BallState createState() => BallState();
}

class BallState extends State<Ball> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;
  late AnimationController _controller4;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat(reverse: true);

    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6),
    )..repeat(reverse: true);

    _controller3 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 7),
    )..repeat(reverse: true);

    _controller4 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        _buildAnimatedCircle(
          controller: _controller1,
          color: Colors.blue,
          size: 120,
          startOffset: Offset(size.width * 0.05, size.height * -0.1),
          endOffset: Offset(size.width * 0.3, size.height * 1.2),
        ),
        _buildAnimatedCircle(
          controller: _controller2,
          color: Colors.purple,
          size: 150,
          startOffset: Offset(size.width * 0.8, size.height * -0.1),
          endOffset: Offset(size.width * 0.2, size.height * 0.9),
        ),
        _buildAnimatedCircle(
          controller: _controller3,
          color: Colors.green,
          size: 170,
          startOffset: Offset(size.width * 0.5, size.height * 1.1),
          endOffset: Offset(size.width * 0.2, size.height * -0.2),
        ),
        _buildAnimatedCircle(
          controller: _controller4,
          color: Colors.yellow,
          size: 160,
          startOffset: Offset(size.width * -0.5, size.height * -0.1),
          endOffset: Offset(size.width * 0.8, size.height * 1.1),
        ),
      ],
    );
  }

  Widget _buildAnimatedCircle({
    required AnimationController controller,
    required Color color,
    required double size,
    required Offset startOffset,
    required Offset endOffset,
  }) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final position = Offset.lerp(startOffset, endOffset, controller.value)!;
        return Positioned(
          left: position.dx,
          top: position.dy,
          child: child!,
        );
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [color.withOpacity(0.6), color.withOpacity(0.4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
