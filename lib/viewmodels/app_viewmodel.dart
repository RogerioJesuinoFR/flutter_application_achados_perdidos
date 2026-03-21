import '../models/item_model.dart';
import '../models/user_model.dart';

class AppViewModel {
  static List<ItemPerdido> items = [];
  static Usuario? currentUser;

  void addItem(String nome, String desc, bool status){
    items.add(ItemPerdido(id: DateTime.now().toString(), nomeItem: nome, descricaoItem: desc, status: status,));
  }
}