import 'package:hive/hive.dart';
part 'item_model.g.dart';

@HiveType(typeId: 1)
class ItemPerdido extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String nomeItem;

  @HiveField(2)
  String descricaoItem;

  @HiveField(3)
  bool status;

  @HiveField(4)
  String ownerRa;

  @HiveField(5)
  String? imagePath;

  ItemPerdido({
    required this.id,
    required this.nomeItem,
    required this.descricaoItem,
    this.status = true,
    required this.ownerRa,
    this.imagePath,
  });
}