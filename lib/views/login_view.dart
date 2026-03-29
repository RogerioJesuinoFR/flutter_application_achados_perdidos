import 'package:flutter/material.dart';
import '../viewmodels/app_viewmodel.dart';
import '../models/user_model.dart';
import '../views/register_view.dart';
import '../views/home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _tentarLogin() {
  if (_formKey.currentState!.validate()) {
    // Simulação: Salva o usuário no ViewModel
    AppViewModel.currentUser = Usuario(
      nome: "Usuário Teste", 
      email: _emailController.text, 
      senha: _passwordController.text
    );

    // Navega para a Home (e impede que o botão 'voltar' do celular feche o app)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeView()),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login - Achados e Perdidos")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "E-mail"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Digite seu e-mail";
                  if (!value.contains("@")) return "E-mail inválido";
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: "Senha"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return "A senha deve ter pelo menos 6 caracteres";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _tentarLogin,
                child: Text("Entrar"),
              ),
              TextButton(
                onPressed: () {
                  // Navega para a tela de cadastro
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterView()),
                  );
                },
                child: const Text("Não tem conta? Cadastre-se"),
              )
            ],
          ),
        ),
      ),
    );
  }
}