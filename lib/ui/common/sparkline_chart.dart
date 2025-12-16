import 'package:flutter/material.dart';
import 'dart:math';

class SparklineChart extends StatelessWidget {
  final List<double> data;
  final Color color;
  final double strokeWidth;

  const SparklineChart({
    super.key,
    required this.data,
    this.color = Colors.green,
    this.strokeWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox();

    return CustomPaint(painter: _SparklinePainter(data, color, strokeWidth));
  }
}

class _SparklinePainter extends CustomPainter {
  final List<double> data;
  final Color color;
  final double strokeWidth;

  _SparklinePainter(this.data, this.color, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    final maxVal = data.reduce(max);
    final minVal = data.reduce(min);
    final range = (maxVal == minVal) ? 1.0 : maxVal - minVal;

    final width = size.width;
    final height = size.height;

    final stepX = width / (data.length - 1).clamp(1, double.infinity);

    for (int i = 0; i < data.length; i++) {
      final normalized = (data[i] - minVal) / range;

      final x = i * stepX;
      final y = height - (normalized * height);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) {
    return oldDelegate.data != data || oldDelegate.color != color;
  }
}
