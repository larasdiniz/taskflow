import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';
import 'package:taskflow/models/theme_model.dart';
import 'package:taskflow/screens/splash_screen.dart'; 

void main() {
  runApp(
    DevicePreview(
      enabled: true, 
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (context, themeModel, child) {
          return MaterialApp(
            useInheritedMediaQuery: true,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            title: 'TaskFlow',
            theme: themeModel.currentTheme,
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(), // <-- aqui
          );
        },
      ),
    );
  }
}
