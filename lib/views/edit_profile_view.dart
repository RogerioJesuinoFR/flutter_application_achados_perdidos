import 'package:flutter/material.dart';
import '../viewmodels/app_viewmodel.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _nomeController;
  late TextEditingController _emailController;
  late TextEditingController _senhaController;
  late TextEditingController _raController;

  @override
  void initState() {
    super.initState();
    final usuarioAtual = AppViewModel.currentUser;
    _nomeController = TextEditingController(text: usuarioAtual?.nome ?? '');
    _emailController = TextEditingController(text: usuarioAtual?.email ?? '');
    _senhaController = TextEditingController(text: usuarioAtual?.senha ?? '');
    _raController = TextEditingController(text: usuarioAtual?.ra ?? '');
  }

  bool _validarSenhaForte(String senha) {
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$');
    return regex.hasMatch(senha);
  }

  void _salvarPerfil() {
    if (_formKey.currentState!.validate()) {
      final usuarioAtual = AppViewModel.currentUser;

      if (usuarioAtual != null) {
        usuarioAtual.nome = _nomeController.text;
        usuarioAtual.email = _emailController.text;
        usuarioAtual.senha = _senhaController.text;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Perfil atualizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, true);
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _raController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Perfil"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Icon(Icons.account_circle, size: 80, color: Colors.blue),
              const SizedBox(height: 20),
              
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: "Nome Completo",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) => value == null || value.isEmpty ? "Informe seu nome" : null,
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: _raController,
                enabled: false,
                decoration: InputDecoration(
                  labelText: "RA (Não pode ser alterado)",
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.badge),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                ),
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
                  if (!value.contains("@") || !value.contains(".")) return "E-mail inválido";
                  return null;
                },
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: _senhaController,
                decoration: const InputDecoration(
                  labelText: "Nova Senha",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
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
                  onPressed: _salvarPerfil,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Salvar Alterações", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}