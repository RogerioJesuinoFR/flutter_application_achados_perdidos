import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'models/user_model.dart';
import 'models/item_model.dart';
import 'viewmodels/app_viewmodel.dart';
import 'views/login_view.dart';
import 'views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  Hive.registerAdapter(UsuarioAdapter());
  Hive.registerAdapter(ItemPerdidoAdapter());
  
  await Hive.openBox<Usuario>('usuarios');
  await Hive.openBox<ItemPerdido>('items');
  await Hive.openBox('sessao');

  AppViewModel.carregarSessao();

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          secondary: Colors.orangeAccent,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[100],
        
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
        
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            elevation: 3,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.indigo, width: 2),
          ),
          labelStyle: const TextStyle(color: Colors.indigo),
          prefixIconColor: Colors.indigo,
        ),
        
        cardTheme: CardThemeData( // <-- Apenas adicione "Data" aqui
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          shadowColor: Colors.black26,
        ),
      ),
      home: AppViewModel.currentUser != null ? const HomeView() : const LoginView(),
    );
  }
}