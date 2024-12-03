import 'package:flutter/material.dart';
import 'package:safe_tester/app/core/layout/wrapper.dart';
import 'package:safe_tester/app/core/theme/color_scheme.dart';

class OrdersApp extends StatelessWidget {
  const OrdersApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.platformBrightnessOf(context);

    return MaterialApp(
      title: 'Orders App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: MyColorScheme.lightColorScheme),
      darkTheme: ThemeData(colorScheme: MyColorScheme.darkColorScheme),
      themeMode:
          brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
      home: const LayoutPage(),
    );
  }
}
