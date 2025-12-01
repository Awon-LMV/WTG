import 'package:flutter/material.dart';

void main() async {
  // 1. Обязательная строка для инициализации движка перед запуском асинхронного кода
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Здесь мы будем инициализировать базу данных и зависимости (позже)
  // await initDependencies();

  // 3. Запуск приложения
  runApp(const WTGApp());
}

class WTGApp extends StatelessWidget {
  const WTGApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WTG Map',
      debugShowCheckedModeBanner: false,
      
      // 4. Тема приложения (пока базовая)
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      
      // 5. Главный экран (пока заглушка)
      home: const PlaceholderScreen(),
    );
  }
}

// Временный экран, чтобы проверить, что все работает
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WTG Map Dev')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.map, size: 64, color: Colors.blue),
            const SizedBox(height: 16),
            const Text('Приложение настроено!'),
            const SizedBox(height: 8),
            const Text('Структура папок создана.'),
            const SizedBox(height: 8),
            const Text('Пакеты установлены.'),
          ],
        ),
      ),
    );
  }
}
