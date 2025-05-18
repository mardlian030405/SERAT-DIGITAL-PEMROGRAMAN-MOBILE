import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/drawing_provider.dart';
import '../widgets/drawing_canvas.dart';
import '../widgets/drawing_toolbar.dart';

class DrawingPage extends StatelessWidget {
  const DrawingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DrawingProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Drawing App"),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: provider.undo,
          ),
          IconButton(
            icon: const Icon(Icons.redo),
            onPressed: provider.redo,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: provider.clearCanvas,
          ),
        ],
      ),
      body: Stack(
        children: const [
          DrawingCanvas(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: DrawingToolbar(),
          ),
        ],
      ),
    );
  }
}
