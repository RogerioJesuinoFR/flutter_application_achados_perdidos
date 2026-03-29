import 'package:flutter/material.dart';
import '../viewmodels/app_viewmodel.dart';
import 'register_view.dart';
import 'home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _raController = TextEditingController();
  final _passwordController = TextEditingController();

  void _tentarLogin() {
    if (_formKey.currentState!.validate()) {
      bool sucesso = AppViewModel.fazerLogin(_raController.text, _passwordController.text);

      if (sucesso) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('RA ou senha incorretos. Verifique seus dados.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login - Achados e Perdidos")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _raController,
                decoration: const InputDecoration(
                  labelText: "RA (Registro Acadêmico)",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? "Digite seu RA" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "Senha",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) => value == null || value.isEmpty ? "Digite sua senha" : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _tentarLogin,
                  child: const Text("Entrar"),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterView()));
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