import 'package:flutter/material.dart';
import '../viewmodels/app_viewmodel.dart';

class AddItemView extends StatefulWidget {
  const AddItemView({super.key});

  @override
  State<AddItemView> createState() => _AddItemViewState();
}

class _AddItemViewState extends State<AddItemView> {
  final _formKey = GlobalKey<FormState>();
  
  final _nomeController = TextEditingController();
  final _descController = TextEditingController();
  
  // Variável para controlar se o item é "Perdido" (true) ou "Achado" (false)
  bool _isPerdido = true;

  void _salvarItem() {
    if (_formKey.currentState!.validate()) {
      // Instancia o ViewModel e adiciona o item
      AppViewModel().addItem(
        _nomeController.text,
        _descController.text,
        _isPerdido,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Objeto salvo com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      // Volta para a tela Home
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Objeto"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: "Nome do Objeto (ex: Chave, Carteira)",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Informe o nome do objeto";
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _descController,
                maxLines: 3, // Permite digitar um texto maior
                decoration: const InputDecoration(
                  labelText: "Descrição detalhada",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Informe os detalhes para facilitar";
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              // Switch para escolher entre Achado e Perdido
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isPerdido ? "Status: PERDIDO" : "Status: ACHADO",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _isPerdido ? Colors.red : Colors.green,
                    ),
                  ),
                  Switch(
                    value: _isPerdido,
                    activeColor: Colors.red,
                    inactiveThumbColor: Colors.green,
                    inactiveTrackColor: Colors.green.shade200,
                    onChanged: (value) {
                      setState(() {
                        _isPerdido = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _salvarItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Salvar Objeto", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}