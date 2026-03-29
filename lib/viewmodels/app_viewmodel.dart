import '../models/item_model.dart';
import '../models/user_model.dart';

class AppViewModel {
  static List<ItemPerdido> items = [];
  static List<Usuario> usuarios = [];
  static Usuario? currentUser;

  static String? registrarUsuario(String nome, String ra, String email, String senha) {
    if (usuarios.any((u) => u.ra == ra)) {
      return "Erro: Este RA já está cadastrado!";
    }
    usuarios.add(Usuario(nome: nome, ra: ra, email: email, senha: senha));
    return null;
  }

  static bool fazerLogin(String ra, String senha) {
    try {
      currentUser = usuarios.firstWhere((u) => u.ra == ra && u.senha == senha);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Usuario? buscarUsuarioPorRa(String ra) {
    try {
      return usuarios.firstWhere((u) => u.ra == ra);
    } catch (e) {
      return null;
    }
  }

  void addItem(String nome, String desc, bool status, String? imagePath) {
    if (currentUser == null) return;
    items.add(ItemPerdido(
      id: DateTime.now().toString(),
      nomeItem: nome,
      descricaoItem: desc,
      status: status,
      ownerRa: currentUser!.ra,
      imagePath: imagePath,
    ));
  }

  void editItem(int index, String nome, String desc, bool status) {
    items[index].nomeItem = nome;
    items[index].descricaoItem = desc;
    items[index].status = status;
  }

  void deleteItem(int index) {
    items.removeAt(index);
  }
}