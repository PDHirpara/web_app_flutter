import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/HomePage/Provider/provider.dart';
import 'Screens/HomePage/Views/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider<MenuProvider>(create: (ctx) => MenuProvider()),
      ],
      builder: (ctx, _) => MaterialApp(
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const HomePage(),
          // 'search_engine': (context) => const search_engine(),
        },
      ),
    ),
  );
}
