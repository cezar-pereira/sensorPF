import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

class TopCustomPainter extends CustomPainter {
  final BuildContext context;
  TopCustomPainter(this.context);
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0, 0, 30, 30);
    final startAngle = math.pi;
    final sweepAngle = math.pi;
    final useCenter = false;
    final paint = Paint()
      ..color = Theme.of(context).iconTheme.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
