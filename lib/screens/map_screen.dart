import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import '../widgets/search_bar.dart';
import '../widgets/category_buttons.dart';
import '../widgets/wtg_floating_button.dart';
import '../widgets/layer_controls.dart';
import '../models/map_layer.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMap? mapboxMap;
  String selectedCategory = 'Все';
  
  // Слои карты
  late List<MapLayer> _layers;
  
  // Менеджеры аннотаций для разных слоев
  PointAnnotationManager? _wifiAnnotationManager;
  PointAnnotationManager? _powerbankAnnotationManager;
  
  // ID аннотаций для каждого слоя
  final Map<MapLayerType, List<String>> _annotationIds = {
    MapLayerType.wifi: [],
    MapLayerType.powerbank: [],
  };

  // Координаты центра Москвы
  static const Point _center = Point(
    coordinates: Position(37.6173, 55.7558),
  );

  @override
  void initState() {
    super.initState();
    _initializeLayers();
  }

  void _initializeLayers() {
    _layers = [
      MapLayer(
        type: MapLayerType.wifi,
        name: 'Wi-Fi',
        isVisible: false,
        icon: Icons.wifi,
      ),
      MapLayer(
        type: MapLayerType.powerbank,
        name: 'Повербанки',
        isVisible: false,
        icon: Icons.battery_charging_full,
      ),
    ];
  }

  void _onMapCreated(MapboxMap mapboxMapInstance) {
    mapboxMap = mapboxMapInstance;
    _initializeAnnotationManagers();
  }

  Future<void> _initializeAnnotationManagers() async {
    if (mapboxMap == null) return;

    try {
      _wifiAnnotationManager = await mapboxMap!.annotations
          .createPointAnnotationManager();
      _powerbankAnnotationManager = await mapboxMap!.annotations
          .createPointAnnotationManager();
    } catch (e) {
      debugPrint('Error creating annotation managers: $e');
    }
  }

  Future<void> _toggleLayer(MapLayerType layerType) async {
    if (mapboxMap == null) return;

    final layerIndex = _layers.indexWhere((l) => l.type == layerType);
    if (layerIndex == -1) return;

    final layer = _layers[layerIndex];
    final newVisibility = !layer.isVisible;

    setState(() {
      _layers[layerIndex] = layer.copyWith(isVisible: newVisibility);
    });

    await _updateLayerVisibility(layerType, newVisibility);
  }

  Future<void> _updateLayerVisibility(
    MapLayerType layerType,
    bool isVisible,
  ) async {
    if (mapboxMap == null) return;

    PointAnnotationManager? manager;
    if (layerType == MapLayerType.wifi) {
      manager = _wifiAnnotationManager;
    } else if (layerType == MapLayerType.powerbank) {
      manager = _powerbankAnnotationManager;
    }

    if (manager == null) {
      await _initializeAnnotationManagers();
      if (layerType == MapLayerType.wifi) {
        manager = _wifiAnnotationManager;
      } else if (layerType == MapLayerType.powerbank) {
        manager = _powerbankAnnotationManager;
      }
    }

    if (manager == null) return;

    try {
      if (isVisible) {
        // Создаем аннотации для слоя
        await _createLayerAnnotations(layerType, manager);
      } else {
        // Удаляем все аннотации слоя
        final ids = _annotationIds[layerType] ?? [];
        for (final id in ids) {
          try {
            await manager.delete(id);
          } catch (e) {
            // Игнорируем ошибки удаления
          }
        }
        _annotationIds[layerType] = [];
      }
    } catch (e) {
      debugPrint('Error updating layer visibility: $e');
    }
  }

  Future<void> _createLayerAnnotations(
    MapLayerType layerType,
    PointAnnotationManager manager,
  ) async {
    List<Point> points;
    int iconColor;

    if (layerType == MapLayerType.wifi) {
      // Координаты для маркеров Wi-Fi
      points = [
        const Point(coordinates: Position(37.6173, 55.7558)),
        const Point(coordinates: Position(37.6184, 55.7512)),
        const Point(coordinates: Position(37.6156, 55.7520)),
        const Point(coordinates: Position(37.6200, 55.7500)),
      ];
      iconColor = Colors.blue.value;
    } else {
      // Координаты для повербанков
      points = [
        const Point(coordinates: Position(37.6190, 55.7560)),
        const Point(coordinates: Position(37.6160, 55.7530)),
        const Point(coordinates: Position(37.6210, 55.7510)),
      ];
      iconColor = Colors.green.value;
    }

    final annotationIds = <String>[];

    for (final point in points) {
      try {
        final annotation = PointAnnotationOptions(
          geometry: point,
          textField: '?',
          textColor: Colors.white.value,
          textSize: 18.0,
          iconColor: iconColor,
        );

        final created = await manager.create(annotation);
        annotationIds.add(created.id);
      } catch (e) {
        debugPrint('Error creating annotation: $e');
      }
    }

    _annotationIds[layerType] = annotationIds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // Карта Mapbox
            MapWidget(
              key: const ValueKey("mapWidget"),
              cameraOptions: CameraOptions(
                center: _center,
                zoom: 13.0,
              ),
              styleUri: MapboxStyles.MAPBOX_STREETS,
              textureView: true,
              onMapCreated: _onMapCreated,
            ),

            // Верхняя часть с заголовком
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black,
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 8,
                  bottom: 12,
                ),
                child: Column(
                  children: [
                    // Заголовок с "Готово" и идентификатором
                    Row(
                      children: [
                        const Text(
                          'Готово',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.lock, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '019ab1f6-29ac-7a52-818a-5...',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert, color: Colors.white),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Поисковая строка
                    const CustomSearchBar(),
                    const SizedBox(height: 12),
                    // Кнопки категорий
                    CategoryButtons(
                      selectedCategory: selectedCategory,
                      onCategorySelected: (category) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Кнопки управления слоями (справа)
            LayerControls(
              layers: _layers,
              onLayerToggled: _toggleLayer,
            ),

            // Кнопка WTG в правом нижнем углу (выше нижней панели)
            Positioned(
              bottom: 90,
              right: 16,
              child: const WtGFloatingButton(),
            ),
          ],
        ),
      ),
    );
  }
}
