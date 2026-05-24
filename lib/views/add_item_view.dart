import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // NOVO: Para detectar a Web
import 'package:image_picker/image_picker.dart';
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
  bool _isPerdido = true;
  
  XFile? _imageFile; // MODIFICADO: Usamos XFile em vez de File para funcionar na Web
  final ImagePicker _picker = ImagePicker();

  Future<void> _pegarImagem(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source, imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  void _salvarItem() {
    if (_formKey.currentState!.validate()) {
      AppViewModel().addItem(
        _nomeController.text,
        _descController.text,
        _isPerdido,
        _imageFile?.path, // Envia o caminho
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Objeto salvo!'), backgroundColor: Colors.green),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Novo Objeto")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // ÁREA DA FOTO ADAPTADA PARA WEB
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: _imageFile != null
                    ? (kIsWeb 
                        // Se for Web, renderiza assim
                        ? Image.network(_imageFile!.path, fit: BoxFit.cover) 
                        // Se for Celular, renderiza assim
                        : Image.file(File(_imageFile!.path), fit: BoxFit.cover))
                    : const Icon(Icons.image, size: 50, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _pegarImagem(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Câmera"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _pegarImagem(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: const Text("Galeria"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: "Nome do Objeto", border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? "Informe o nome" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: "Descrição detalhada", border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? "Informe a descrição" : null,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_isPerdido ? "Status: PERDIDO" : "Status: ACHADO",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _isPerdido ? Colors.red : Colors.green),
                  ),
                  Switch(
                    value: _isPerdido,
                    activeColor: Colors.red,
                    onChanged: (value) => setState(() => _isPerdido = value),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _salvarItem,
                  child: const Text("Salvar Objeto"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}