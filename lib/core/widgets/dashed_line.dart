import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  final double height;
  final double dashWidth;
  final Color? color;

  const DashedLine({
    this.height = 1,
    this.dashWidth = 8,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedLinePainter(
          height: height, dashWidth: dashWidth, color: color ?? Colors.grey[400]!),
      child: SizedBox(height: height),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final double height;
  final double dashWidth;
  final Color color;

  _DashedLinePainter({
    required this.height,
    required this.dashWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = height;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth * 2;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
