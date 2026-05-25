import 'package:hive/hive.dart';
import '../models/item_model.dart';
import '../models/user_model.dart';

class AppViewModel {
  static Box<ItemPerdido> get itemsBox => Hive.box<ItemPerdido>('items');
  static Box<Usuario> get usuariosBox => Hive.box<Usuario>('usuarios');
  static Box get sessaoBox => Hive.box('sessao'); // NOVO: Banco para salvar o login
  
  static Usuario? currentUser;

  // NOVO: Verifica se o usuário já estava logado ao abrir o app
  static void carregarSessao() {
    String? loggedRa = sessaoBox.get('usuario_logado');
    if (loggedRa != null) {
      currentUser = buscarUsuarioPorRa(loggedRa);
    }
  }

  static String? registrarUsuario(String nome, String ra, String email, String senha) {
    if (usuariosBox.values.any((u) => u.ra == ra)) {
      return "Erro: Este RA já está cadastrado!";
    }
    usuariosBox.add(Usuario(nome: nome, ra: ra, email: email, senha: senha));
    return null;
  }

  static bool fazerLogin(String ra, String senha) {
    try {
      currentUser = usuariosBox.values.firstWhere((u) => u.ra == ra && u.senha == senha);
      sessaoBox.put('usuario_logado', ra); // NOVO: Salva o RA no banco para manter o login
      return true;
    } catch (e) {
      return false;
    }
  }

  // NOVO: Função para deslogar com segurança
  static void fazerLogout() {
    currentUser = null;
    sessaoBox.delete('usuario_logado');
  }

  static Usuario? buscarUsuarioPorRa(String ra) {
    try {
      return usuariosBox.values.firstWhere((u) => u.ra == ra);
    } catch (e) {
      return null;
    }
  }

  void addItem(String nome, String desc, bool status, String? imagePath) {
    if (AppViewModel.currentUser == null) return;
    AppViewModel.itemsBox.add(ItemPerdido(
      id: DateTime.now().toString(),
      nomeItem: nome,
      descricaoItem: desc,
      status: status,
      ownerRa: AppViewModel.currentUser!.ra,
      imagePath: imagePath,
    ));
  }

  void editItem(dynamic key, String nome, String desc, bool status) {
    final item = AppViewModel.itemsBox.get(key);
    if (item != null) {
      item.nomeItem = nome;
      item.descricaoItem = desc;
      item.status = status;
      item.save();
    }
  }

  void deleteItem(dynamic key) {
    AppViewModel.itemsBox.delete(key);
  }
}