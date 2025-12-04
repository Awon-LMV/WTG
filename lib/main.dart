import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'screens/main_navigation_screen.dart';

void main() async {
  // 1. Обязательная строка для инициализации движка перед запуском асинхронного кода
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Инициализация Mapbox
  // TODO: Замените YOUR_MAPBOX_ACCESS_TOKEN на ваш реальный токен
  // Получить токен можно здесь: https://account.mapbox.com/access-tokens/
  await MapboxOptions.setAccessToken('YOUR_MAPBOX_ACCESS_TOKEN');

  // 3. Здесь мы будем инициализировать базу данных и зависимости (позже)
  // await initDependencies();

  // 4. Устанавливаем ориентацию экрана только портретная
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 5. Запуск приложения
  runApp(const WTGApp());
}

class WTGApp extends StatelessWidget {
  const WTGApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WTG Map',
      debugShowCheckedModeBanner: false,
      
      // Тема приложения
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
        ),
      ),
      
      // Главный экран с навигацией
      home: const MainNavigationScreen(),
    );
  }
}
