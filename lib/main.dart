import 'package:flutter/material.dart';
import 'view/ideas_list_screen.dart';

void main() {
  runApp(CreativeIdeasApp());
}

class CreativeIdeasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Creative Ideas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: IdeasListScreen(),
    );
  }
}
