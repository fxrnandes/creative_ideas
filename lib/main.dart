import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart'; // Importar Firebase
import 'view/ideas_list_screen.dart';
import 'viewmodel/ideas_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Garante que o Flutter esteja inicializado
  await Firebase.initializeApp(); // Inicializa o Firebase

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IdeasProvider()),
      ],
      child: CreativeIdeasApp(),
    ),
  );
}

class CreativeIdeasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Creative Ideas',
      theme: ThemeData(
        primaryColor: Color(0xFF5DADEC),
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
      ),
      home: IdeasListScreen(),
    );
  }
}
