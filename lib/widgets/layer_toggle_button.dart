import 'package:flutter/material.dart';
import '../models/map_layer.dart';

class LayerToggleButton extends StatelessWidget {
  final MapLayer layer;
  final VoidCallback onTap;

  const LayerToggleButton({
    super.key,
    required this.layer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: layer.isVisible ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          layer.icon,
          color: layer.isVisible ? Colors.white : Colors.grey[700],
          size: 24,
        ),
      ),
    );
  }
}

