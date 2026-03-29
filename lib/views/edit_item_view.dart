import 'package:flutter/material.dart';
import '../viewmodels/app_viewmodel.dart';
import '../models/item_model.dart';

class EditItemView extends StatefulWidget {
  final ItemPerdido item;
  final int index;
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
    _nomeController = TextEditingController(text: widget.item.nomeItem);
    _descController = TextEditingController(text: widget.item.descricaoItem);
    _isPerdido = widget.item.status;
  }

  void _atualizarItem() {
    if (_formKey.currentState!.validate()) {
      AppViewModel().editItem(widget.index, _nomeController.text, _descController.text, _isPerdido);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Atualizado!'), backgroundColor: Colors.green));
      Navigator.pop(context, true);
    }
  }

  void _excluirItem() {
    AppViewModel().deleteItem(widget.index);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Objeto excluído!'), backgroundColor: Colors.red));
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Objeto"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Excluir objeto?"),
                  content: const Text("Esta ação não pode ser desfeita."),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _excluirItem();
                      }, 
                      child: const Text("Excluir", style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: "Nome", border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? "Informe o nome" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: "Descrição", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: Text(_isPerdido ? "PERDIDO" : "ACHADO", style: TextStyle(color: _isPerdido ? Colors.red : Colors.green, fontWeight: FontWeight.bold)),
                value: _isPerdido,
                activeColor: Colors.red,
                onChanged: (value) => setState(() => _isPerdido = value),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _atualizarItem,
                child: const Text("Salvar Alterações"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}