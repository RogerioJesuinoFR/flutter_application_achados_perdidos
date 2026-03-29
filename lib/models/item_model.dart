class ItemPerdido {
  String id;
  String nomeItem;
  String descricaoItem;
  bool status;
  String ownerRa;
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