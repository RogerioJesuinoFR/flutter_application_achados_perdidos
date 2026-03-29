import 'package:flutter/material.dart';
import '../viewmodels/app_viewmodel.dart';
import '../models/item_model.dart';

class EditItemView extends StatefulWidget {
  final ItemPerdido item;
  final int index;

  // O construtor exige que passemos qual item vamos editar
  const EditItemView({super.key, required this.item, required this.index});

  @override
  State<EditItemView> createState() => _EditItemViewState();
}

class _EditItemViewState extends State<EditItemView> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _nomeController;
  late TextEditingController _descController;
  late bool _isPerdido;

  @override
  void initState() {
    super.initState();
    // Preenche os campos com os dados atuais do objeto que veio da Home
    _nomeController = TextEditingController(text: widget.item.nomeItem);
    _descController = TextEditingController(text: widget.item.descricaoItem);
    _isPerdido = widget.item.status;
  }

  void _atualizarItem() {
    if (_formKey.currentState!.validate()) {
      // Chama a nova função do ViewModel para atualizar o item
      AppViewModel().editItem(
        widget.index,
        _nomeController.text,
        _descController.text,
        _isPerdido,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Objeto atualizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      // Volta para a Home avisando que houve alteração (true)
      Navigator.pop(context, true);
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
        title: const Text("Editar Objeto"),
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
                  labelText: "Nome do Objeto",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? "Informe o nome" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Descrição detalhada",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? "Informe a descrição" : null,
              ),
              const SizedBox(height: 20),
              
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
                  onPressed: _atualizarItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // Cor diferente para edição
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