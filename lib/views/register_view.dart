import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../viewmodels/app_viewmodel.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  
  // Controladores para capturar o texto digitado
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  void _cadastrar() {
    // Valida se todos os campos estão preenchidos corretamente
    if (_formKey.currentState!.validate()) {
      
      // Salva o novo usuário no nosso "banco de dados" (ViewModel)
      AppViewModel.currentUser = Usuario(
        nome: _nomeController.text,
        email: _emailController.text,
        senha: _senhaController.text,
      );

      // Mostra uma mensagem de sucesso na parte inferior da tela
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuário cadastrado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      // Volta para a tela anterior (Login)
      Navigator.pop(context);
    }
  }

  // Boa prática: sempre descartar os controllers quando a tela for fechada
  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar Conta"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      // SingleChildScrollView evita que o teclado cubra os campos de texto
      body: SingleChildScrollView( 
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: "Nome Completo",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Informe seu nome";
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "E-mail",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Informe seu e-mail";
                  if (!value.contains("@")) return "E-mail inválido";
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _senhaController,
                decoration: const InputDecoration(
                  labelText: "Senha",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true, // Esconde a senha com asteriscos
                validator: (value) {
                  if (value == null || value.length < 6) return "Mínimo de 6 caracteres";
                  return null;
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _cadastrar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    "Confirmar Cadastro", 
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}