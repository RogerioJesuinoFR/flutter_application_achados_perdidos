import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'models/user_model.dart';
import 'models/item_model.dart';
import 'viewmodels/app_viewmodel.dart'; // Importe o ViewModel
import 'views/login_view.dart';
import 'views/home_view.dart'; // Importe a Home

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  Hive.registerAdapter(UsuarioAdapter());
  Hive.registerAdapter(ItemPerdidoAdapter());
  
  await Hive.openBox<Usuario>('usuarios');
  await Hive.openBox<ItemPerdido>('items');
  await Hive.openBox('sessao'); // NOVO: Inicia o banco de sessão

  AppViewModel.carregarSessao(); // NOVO: Restaura o login se existir

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
      // NOVO: Se tiver usuário na memória, vai direto pra Home, senão, Login
      home: AppViewModel.currentUser != null ? const HomeView() : const LoginView(),
    );
  }
}