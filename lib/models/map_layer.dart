enum MapLayerType {
  wifi,
  powerbank,
}

class MapLayer {
  final MapLayerType type;
  final String name;
  final bool isVisible;
  final IconData icon;

  MapLayer({
    required this.type,
    required this.name,
    required this.isVisible,
    required this.icon,
  });

  MapLayer copyWith({
    MapLayerType? type,
    String? name,
    bool? isVisible,
    IconData? icon,
  }) {
    return MapLayer(
      type: type ?? this.type,
      name: name ?? this.name,
      isVisible: isVisible ?? this.isVisible,
      icon: icon ?? this.icon,
    );
  }
}

