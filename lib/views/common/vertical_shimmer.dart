import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
class VerticalShimmer extends StatelessWidget {
  const VerticalShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    return Animate(
      effects: const [
        ShimmerEffect(
          curve: Curves.easeInBack,
          duration: Duration(seconds: 7),
          colors: [
            Colors.grey,
            Colors.lightBlue,
            Colors.lime,
          ],
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: size.height * 0.15,
        width: size.width,
        color: Colors.lightGreenAccent,
      ),
    );
  }
}