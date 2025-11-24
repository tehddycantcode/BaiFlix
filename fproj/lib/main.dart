import 'package:flutter/material.dart';
import 'routes/app_router.dart';

void main() {
  runApp(const BaiflixApp());
}

class BaiflixApp extends StatelessWidget {
  const BaiflixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BaiFlix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.dark(
          primary: Colors.red,
          secondary: Colors.red,
          surface: Colors.grey[900]!,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      routerConfig: appRouter,
    );
  }
}
