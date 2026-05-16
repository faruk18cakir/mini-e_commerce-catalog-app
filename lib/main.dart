import 'package:flutter/material.dart';

import 'routes/app_routes.dart';
import 'screens/main_screen.dart';
import 'screens/product_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Mini Katalog',

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      initialRoute: AppRoutes.home,

      routes: {
        AppRoutes.home: (context) =>
            const MainScreen(),

        AppRoutes.productDetail: (context) =>
            const ProductDetailScreen(),
      },
    );
  }
}