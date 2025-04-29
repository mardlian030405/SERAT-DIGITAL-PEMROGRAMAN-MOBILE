import 'package:flutter/material.dart';

class NavIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Widget page;

  const NavIcon({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.page,
  });

  @override
  State<NavIcon> createState() => _NavIconState();
}

class _NavIconState extends State<NavIcon> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTapDown: (_) {
            setState(() {
              _scale = 0.9;
            });
          },
          onTapUp: (_) {
            setState(() {
              _scale = 1.0;
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => widget.page),
            );
          },
          onTapCancel: () {
            setState(() {
              _scale = 1.0;
            });
          },
          child: AnimatedScale(
            scale: _scale,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOut,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _withModifiedOpacity(widget.color, 0.7),
                    widget.color,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: _withModifiedOpacity(widget.color, 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                widget.icon,
                size: 28,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Color _withModifiedOpacity(Color color, double opacity) {
    return color.withValues(
      red: color.r.toDouble(),
      green: color.g.toDouble(),
      blue: color.b.toDouble(),
      alpha: (color.a.toDouble() * opacity).clamp(0.0, 255.0),
    );
  }
}
