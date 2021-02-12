import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BottomCustomPainter extends CustomPainter {
  final BuildContext context;
  BottomCustomPainter(this.context);
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0, 0, 50, 50);
    final startAngle = -0.98;
    final sweepAngle = 5.1;
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
