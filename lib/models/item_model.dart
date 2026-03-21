class ItemPerdido {
  String id;
  String nomeItem;
  String descricaoItem;
  bool status;

  ItemPerdido({
    required this.id,
    required this.nomeItem,
    required this.descricaoItem,
    this.status = true
  });
}