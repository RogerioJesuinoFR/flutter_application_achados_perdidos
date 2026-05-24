import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class Usuario extends HiveObject {
  @HiveField(0)
  String nome;

  @HiveField(1)
  String ra;

  @HiveField(2)
  String email;

  @HiveField(3)
  String senha;

  Usuario({required this.nome, required this.ra, required this.email, required this.senha});
}