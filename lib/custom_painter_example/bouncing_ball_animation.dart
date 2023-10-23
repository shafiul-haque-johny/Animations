
import 'package:flutter/material.dart';

class BouncingBallAnimation extends StatefulWidget {
  const BouncingBallAnimation({super.key});

  @override
  State<BouncingBallAnimation> createState() => _BouncingBallAnimationState();
}

class _BouncingBallAnimationState extends State<BouncingBallAnimation>
    with SingleTickerProviderStateMixin {
  
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1500,
      ),
    );

    controller.addListener(() {
      if (animation.isCompleted)
      {
        controller.reverse();
      }
      else if (animation.isDismissed){
        controller.forward();
      }
    });

    animation = Tween<double>(begin: 0, end: 1).animate(controller);

    // OR use
    /*animation.addStatusListener((status) { 
      if (status == AnimationStatus.completed)
      {
        controller.reverse();
      }
      else if (status == AnimationStatus.dismissed){
        controller.forward();
      }
    }); */

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedBuilder(
              animation: animation,
              builder: (context, child) => CustomPaint(
                size: const Size(250, 250),
                painter: BouncingBallpainter(animation.value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BouncingBallpainter extends CustomPainter {
  
  final double animationValue;

  BouncingBallpainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      Offset(size.width, size.height - (size.height * animationValue),),
      20,
      Paint()..color = Colors.green,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
