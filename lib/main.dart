import 'package:flutter/material.dart';
import 'package:yuka/screens/list.dart';

import 'colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.purpleAccent,
          primaryColor: AppColors.primary,
          primaryColorDark: AppColors.primaryDark),
      home: ProductsListScreen(),
    );
  }
}
