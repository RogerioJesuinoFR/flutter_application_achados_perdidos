import 'dart:io';
import 'package:flutter/material.dart';
import '../viewmodels/app_viewmodel.dart';
import '../models/item_model.dart';
import 'add_item_view.dart';
import 'edit_profile_view.dart';
import 'edit_item_view.dart';
import 'login_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  
  void _mostrarContatoDono(ItemPerdido item) {
    final dono = AppViewModel.buscarUsuarioPorRa(item.ownerRa);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Entrar em Contato"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Este item foi cadastrado por:", style: TextStyle(color: Colors.grey[700])),
            const SizedBox(height: 10),
            Text("👤 Nome: ${dono?.nome ?? 'Desconhecido'}", style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("🎓 RA: ${dono?.ra ?? 'N/A'}"),
            Text("📧 E-mail: ${dono?.email ?? 'N/A'}"),
            const SizedBox(height: 20),
            const Text("Envie um e-mail para combinar a devolução/retirada!", style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Fechar"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final usuario = AppViewModel.currentUser;
    final itens = AppViewModel.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Achados e Perdidos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: "Editar Perfil",
            onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileView()));
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            tooltip: "Sair",
            onPressed: () {
              AppViewModel.currentUser = null;
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginView()));
            },
          )
        ],
      ),
      body: itens.isEmpty
          ? const Center(child: Text("Nenhum objeto cadastrado na faculdade ainda."))
          : ListView.builder(
              itemCount: itens.length,
              itemBuilder: (context, index) {
                final item = itens[index];
                final isMeuItem = item.ownerRa == usuario?.ra;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: item.imagePath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.file(File(item.imagePath!), width: 50, height: 50, fit: BoxFit.cover),
                          )
                        : Icon(item.status ? Icons.search_off : Icons.check_circle, 
                               color: item.status ? Colors.red : Colors.green, size: 40),
                    
                    title: Text(item.nomeItem, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(isMeuItem ? "Cadastrado por você" : "Cadastrado por outro aluno"),
                    trailing: Text(
                      item.status ? "Perdido" : "Achado",
                      style: TextStyle(color: item.status ? Colors.red : Colors.green, fontWeight: FontWeight.bold),
                    ),
                    
                    onTap: () async {
                      if (isMeuItem) {
                        final atualizou = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditItemView(item: item, index: index)),
                        );
                        if (atualizou == true) setState(() {});
                      } else {
                        _mostrarContatoDono(item);
                      }
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddItemView()))
              .then((_) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}