import 'package:flutter/material.dart';
import '../models/map_layer.dart';
import 'layer_toggle_button.dart';

class LayerControls extends StatelessWidget {
  final List<MapLayer> layers;
  final Function(MapLayerType) onLayerToggled;

  const LayerControls({
    super.key,
    required this.layers,
    required this.onLayerToggled,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      top: 200,
      child: Column(
        children: layers.map((layer) {
          return LayerToggleButton(
            layer: layer,
            onTap: () => onLayerToggled(layer.type),
          );
        }).toList(),
      ),
    );
  }
}

