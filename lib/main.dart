import 'package:hive_flutter/hive_flutter.dart';
import 'models/user_model.dart';
import 'models/item_model.dart';

import 'package:flutter/material.dart';
import 'views/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UsuarioAdapter());
  Hive.registerAdapter(ItemPerdidoAdapter());
  await Hive.openBox<Usuario>('usuarios');
  await Hive.openBox<ItemPerdido>('items');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Achados e Perdidos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: LoginView(),
    );
  }
}