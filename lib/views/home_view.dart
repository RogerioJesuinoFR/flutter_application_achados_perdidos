import 'package:flutter/material.dart';
import '../viewmodels/app_viewmodel.dart';
import 'add_item_view.dart';
import 'edit_profile_view.dart';
import 'edit_item_view.dart'; // Importação da nova tela de edição

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    // Pega o usuário logado para dar boas-vindas
    final usuario = AppViewModel.currentUser;
    // Pega a lista de itens
    final itens = AppViewModel.items;

    return Scaffold(
      appBar: AppBar(
        title: Text("Olá, ${usuario?.nome ?? 'Usuário'}!"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          // BOTÃO DE EDITAR PERFIL
          IconButton(
            icon: const Icon(Icons.manage_accounts),
            onPressed: () async {
              final atualizou = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfileView()),
              );
              
              if (atualizou == true) {
                setState(() {});
              }
            },
          ),
          // BOTÃO DE LOGOUT
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              AppViewModel.currentUser = null;
              Navigator.pop(context); // Volta pro Login
            },
          )
        ],
      ),
      body: itens.isEmpty
          ? const Center(
              child: Text(
                "Nenhum objeto cadastrado ainda.\nClique no + para adicionar.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: itens.length,
              itemBuilder: (context, index) {
                final item = itens[index];
                
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Icon(
                      item.status ? Icons.search_off : Icons.check_circle,
                      color: item.status ? Colors.red : Colors.green,
                      size: 30,
                    ),
                    title: Text(
                      item.nomeItem,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(item.descricaoItem),
                    trailing: Text(
                      item.status ? "Perdido" : "Achado",
                      style: TextStyle(
                        color: item.status ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // ==========================================
                    // AQUI ESTÁ A PARTE NOVA: O clique no item
                    // ==========================================
                    onTap: () async {
                      // Navega para a tela de edição passando o item e a posição dele na lista (index)
                      final atualizou = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditItemView(item: item, index: index),
                        ),
                      );
                      
                      // Se a tela de edição salvou com sucesso e retornou "true", atualizamos a Home
                      if (atualizou == true) {
                        setState(() {});
                      }
                    },
                    // ==========================================
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navega para a tela de adicionar item
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddItemView()),
          ).then((_) {
            // Atualiza a Home quando fechar o cadastro do objeto
            setState(() {}); 
          });
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}