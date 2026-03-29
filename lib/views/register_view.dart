import 'package:flutter/material.dart';
import '../viewmodels/app_viewmodel.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _raController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  bool _validarSenhaForte(String senha) {
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$');
    return regex.hasMatch(senha);
  }

  void _cadastrar() {
    if (_formKey.currentState!.validate()) {
      String? erro = AppViewModel.registrarUsuario(
        _nomeController.text,
        _raController.text,
        _emailController.text,
        _senhaController.text,
      );

      if (erro != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(erro), backgroundColor: Colors.red),
        );
      } else {
        // Sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Conta criada! Faça login.'), backgroundColor: Colors.green),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Criar Conta")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: "Nome Completo", border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? "Informe seu nome" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _raController,
                decoration: const InputDecoration(labelText: "RA", border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? "Informe seu RA" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "E-mail", border: OutlineInputBorder()),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Informe seu e-mail";
                  if (!value.contains("@") || !value.contains(".")) return "E-mail inválido";
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _senhaController,
                decoration: const InputDecoration(
                  labelText: "Senha",
                  border: OutlineInputBorder(),
                  helperText: "Mín. 8 caracteres, 1 Maiúscula, 1 Minúscula, 1 Número e 1 Símbolo",
                  helperMaxLines: 2,
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Informe a senha";
                  if (!_validarSenhaForte(value)) return "A senha não atende aos requisitos de segurança";
                  return null;
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _cadastrar,
                  child: const Text("Confirmar Cadastro"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}