import 'package:flutter/material.dart';
import 'package:roomrental_app/navigatorBar.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     
    return MaterialApp(
      title: 'Room Rental App',
        debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NavigatorBar(),
    );
  }
}