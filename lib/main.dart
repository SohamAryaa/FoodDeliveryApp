import 'package:flutter/material.dart';

import 'sign_in_screen.dart';

void main() {
  runApp(FoodDeliveryApp());
}

class FoodDeliveryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInScreen(),
    );
  }
}
