import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/drawing_provider.dart';

class DrawingToolbar extends StatelessWidget {
  const DrawingToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DrawingProvider>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 6,
        )
      ]),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              provider.isEraser ? Icons.cleaning_services : Icons.edit,
              color: provider.isEraser ? Colors.red : Colors.black,
            ),
            onPressed: provider.toggleEraser,
          ),
          Expanded(
            child: Slider(
              min: 1,
              max: 20,
              divisions: 19,
              value: provider.strokeWidth,
              label: '${provider.strokeWidth.toInt()} px',
              onChanged: provider.setStrokeWidth,
              activeColor: Colors.indigo,
            ),
          ),
          const ColorPickerButton(Colors.black),
          const ColorPickerButton(Colors.blue),
          const ColorPickerButton(Colors.red),
          const ColorPickerButton(Colors.green),
          const ColorPickerButton(Colors.orange),
        ],
      ),
    );
  }
}

class ColorPickerButton extends StatelessWidget {
  final Color color;
  const ColorPickerButton(this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<DrawingProvider>().setColor(color),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade400),
        ),
      ),
    );
  }
}
