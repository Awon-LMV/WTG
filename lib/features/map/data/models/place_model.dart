import 'package:isar/isar.dart';

// Эта строка нужна для генератора кода (он создаст файл place_model.g.dart)
part 'place_model.g.dart';

@collection // Говорим Isar, что это таблица в базе данных
class PlaceModel {
  // Уникальный ID. Isar сам будет давать номера (1, 2, 3...)
  Id id = Isar.autoIncrement;

  // @Index означает, что по этому полю можно быстро искать
  // type: IndexType.value помогает искать по части слова (для поиска)
  @Index(type: IndexType.value, caseSensitive: false)
  late String name;

  late String description;

  // Храним координаты раздельно, как и договаривались
  late double latitude;
  late double longitude;

  // Категория (например: "cafe", "museum")
  @Index()
  late String category;

  // Теги храним списком строк ["wifi", "quiet", "cheap"]
  // Isar позволяет эффективно фильтровать по элементам списка
  @Index(composite: [CompositeIndex('category')]) // Сложный индекс для супер-быстрых фильтров
  List<String> tags = [];

  // Ссылки на фото (локальные пути или URL)
  List<String> photos = [];

  // Рейтинг (из диаграммы)
  double rating = 0.0;

  // График работы (пока строкой, позже можем усложнить)
  // "Пн-Пт: 10-22, Сб-Вс: 12-24"
  String? openingHours;

  // Поле для "Избранного" (локальное состояние)
  bool isFavorite = false;
}

