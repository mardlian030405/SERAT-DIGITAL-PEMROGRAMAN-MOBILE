import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/drawing_provider.dart';
import 'dart:ui' as ui;

class DrawingCanvas extends StatefulWidget {
  const DrawingCanvas({super.key});

  @override
  State<DrawingCanvas> createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<DrawingCanvas> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<DrawingProvider>();

    return Listener(
      onPointerMove: (details) {
        final box = context.findRenderObject() as RenderBox;
        final point = box.globalToLocal(details.position);
        provider.addPoint(point);
        setState(() {});
      },
      onPointerUp: (_) {
        provider.endStroke();
      },
      child: Consumer<DrawingProvider>(
        builder: (_, provider, __) {
          return CustomPaint(
            painter: _DrawingPainter(provider.points),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class _DrawingPainter extends CustomPainter {
  final List<DrawingPoint?> points;
  _DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];

      if (p1 != null && p2 != null) {
        canvas.drawLine(p1.point, p2.point, p1.paint);
      } else if (p1 != null && p2 == null) {
        canvas.drawPoints(ui.PointMode.points, [p1.point], p1.paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
