import 'package:flutter/material.dart';

class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    final path = Path();

    path.moveTo(50, 100);

    path.lineTo(size.width - 50, 100);

    path.lineTo(size.width - 150, 100);
    path.lineTo(size.width - 200, 150);
    path.lineTo(size.width - 250, 100);

    path.lineTo(size.width - 50, size.height - 50);

    path.lineTo(50, size.height - 50);

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
