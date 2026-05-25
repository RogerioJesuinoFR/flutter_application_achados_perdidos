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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeView()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('RA ou senha incorretos.'), backgroundColor: Colors.redAccent),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fundo com Gradiente
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              color: Colors.white.withOpacity(0.95),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.travel_explore, size: 80, color: Colors.indigo),
                      const SizedBox(height: 10),
                      const Text(
                        "Achados & Perdidos",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo),
                      ),
                      const SizedBox(height: 30),
                      
                      TextFormField(
                        controller: _raController,
                        decoration: const InputDecoration(labelText: "RA (Registro Acadêmico)", prefixIcon: Icon(Icons.badge)),
                        keyboardType: TextInputType.number,
                        validator: (value) => value == null || value.isEmpty ? "Digite seu RA" : null,
                      ),
                      const SizedBox(height: 15),
                      
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(labelText: "Senha", prefixIcon: Icon(Icons.lock)),
                        obscureText: true,
                        validator: (value) => value == null || value.isEmpty ? "Digite sua senha" : null,
                      ),
                      const SizedBox(height: 25),
                      
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _tentarLogin,
                          child: const Text("ENTRAR", style: TextStyle(letterSpacing: 1.5)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterView()));
                        },
                        child: const Text(
                          "Novo por aqui? Crie sua conta",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}