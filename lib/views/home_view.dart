import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [Icon(Icons.contact_mail, color: Colors.indigo), SizedBox(width: 10), Text("Contato")],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Dono do item:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 10),
            Text("👤 Nome: ${dono?.nome ?? 'Desconhecido'}"),
            Text("🎓 RA: ${dono?.ra ?? 'N/A'}"),
            Text("📧 E-mail: ${dono?.email ?? 'N/A'}"),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Fechar")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final usuario = AppViewModel.currentUser;
    final itens = AppViewModel.itemsBox.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Achados & Perdidos", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileView()));
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              AppViewModel.fazerLogout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginView()));
            },
          )
        ],
      ),
      body: itens.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox_outlined, size: 80, color: Colors.grey.shade400),
                  const SizedBox(height: 15),
                  Text("Nenhum objeto registrado ainda.", style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: itens.length,
              itemBuilder: (context, index) {
                final item = itens[index];
                final isMeuItem = item.ownerRa == usuario?.ra;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: item.imagePath != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: kIsWeb
                                  ? Image.network(item.imagePath!, fit: BoxFit.cover)
                                  : Image.file(File(item.imagePath!), fit: BoxFit.cover),
                            )
                          : Icon(item.status ? Icons.search_off : Icons.check_circle,
                              color: item.status ? Colors.redAccent : Colors.green, size: 35),
                    ),
                    title: Text(item.nomeItem, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: item.status ? Colors.red.shade100 : Colors.green.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item.status ? "PERDIDO" : "ACHADO",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: item.status ? Colors.red.shade700 : Colors.green.shade700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              isMeuItem ? "Seu item" : "De outro aluno",
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontStyle: FontStyle.italic),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: isMeuItem ? const Icon(Icons.edit, color: Colors.indigo) : const Icon(Icons.chat_bubble_outline),
                    onTap: () async {
                      if (isMeuItem) {
                        final key = AppViewModel.itemsBox.keyAt(index);
                        final atualizou = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditItemView(item: item, itemKey: key)),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddItemView())).then((_) => setState(() {}));
        },
        backgroundColor: Colors.orangeAccent, // Destaque para o botão de adicionar
        icon: const Icon(Icons.add),
        label: const Text("Novo Item", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}