import 'package:flutter/material.dart';

class DrawingPoint {
  final Offset point;
  final Paint paint;
  DrawingPoint({required this.point, required this.paint});
}

class DrawingProvider extends ChangeNotifier {
  final List<DrawingPoint?> _points = [];
  final List<DrawingPoint?> _undoStack = [];

  Color _color = Colors.black;
  double _strokeWidth = 4.0;
  bool _isEraser = false;

  List<DrawingPoint?> get points => _points;
  bool get isEraser => _isEraser;
  double get strokeWidth => _strokeWidth;

  Paint get _currentPaint => Paint()
    ..color = _isEraser ? Colors.white : _color
    ..strokeCap = StrokeCap.round
    ..strokeWidth = _strokeWidth
    ..strokeJoin = StrokeJoin.round;

  void addPoint(Offset offset) {
    _points.add(DrawingPoint(point: offset, paint: _currentPaint));
  }

  void endStroke() {
    _points.add(null);
    notifyListeners();
  }

  void undo() {
    if (_points.isEmpty) return;
    while (_points.isNotEmpty) {
      var removed = _points.removeLast();
      _undoStack.add(removed);
      if (removed == null) break;
    }
    notifyListeners();
  }

  void redo() {
    if (_undoStack.isEmpty) return;
    while (_undoStack.isNotEmpty) {
      var restored = _undoStack.removeLast();
      _points.add(restored);
      if (restored == null) break;
    }
    notifyListeners();
  }

  void clearCanvas() {
    _points.clear();
    _undoStack.clear();
    notifyListeners();
  }

  void toggleEraser() {
    _isEraser = !_isEraser;
    notifyListeners();
  }

  void setStrokeWidth(double width) {
    _strokeWidth = width;
    notifyListeners();
  }

  void setColor(Color color) {
    _color = color;
    _isEraser = false;
    notifyListeners();
  }
}
