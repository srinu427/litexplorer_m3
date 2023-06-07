import 'dart:ui';

import 'package:flutter/material.dart';

class BlurWrapper extends StatelessWidget{
  final BorderRadiusGeometry? clipBorderRadius;
  final CustomClipper<RRect>? clipper;
  final Clip clipBehavior;
  final double sigmaX;
  final double sigmaY;
  final TileMode tileMode;
  final Widget child;

  const BlurWrapper(
    {
      this.clipBorderRadius = BorderRadius.zero,
      this.clipper,
      this.clipBehavior = Clip.antiAlias,
      required this.sigmaX,
      required this.sigmaY,
      this.tileMode = TileMode.mirror,
      required this.child,
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: clipBorderRadius,
      clipper: clipper,
      clipBehavior: clipBehavior,
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: sigmaX,
            sigmaY: sigmaX,
            tileMode: tileMode
        ),
        child: child,
      ),
    );
  }
}