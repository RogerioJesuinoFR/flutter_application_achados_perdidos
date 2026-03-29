import 'package:flutter/material.dart';
import '../viewmodels/app_viewmodel.dart';
import '../views/add_item_view.dart';
import '../views/edit_profile_view.dart';

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
          // BOTÃO NOVO DE EDITAR PERFIL
          IconButton(
            icon: const Icon(Icons.manage_accounts),
            onPressed: () async {
              // Espera a tela de edição fechar para ver se precisa atualizar a Home
              final atualizou = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfileView()),
              );

              // Se o usuário salvou o perfil (retornou true), atualiza a Home
              if (atualizou == true) {
                setState(() {});
              }
            },
          ),
          // BOTÃO DE LOGOUT QUE JÁ EXISTIA
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              AppViewModel.currentUser = null;
              Navigator.pop(context);
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
            // Quando a tela AddItemView fechar, isso aqui é executado
            // Ele força a Home a reconstruir e mostrar os itens atualizados
            setState(() {}); 
          });
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}