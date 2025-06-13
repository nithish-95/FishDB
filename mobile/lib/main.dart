import 'package:flutter/material.dart';
import 'pages/fish_guide_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FishGuide',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FishGuidePage(),
    );
  }
}
