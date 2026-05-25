// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemPerdidoAdapter extends TypeAdapter<ItemPerdido> {
  @override
  final int typeId = 1;

  @override
  ItemPerdido read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemPerdido(
      id: fields[0] as String,
      nomeItem: fields[1] as String,
      descricaoItem: fields[2] as String,
      status: fields[3] as bool,
      ownerRa: fields[4] as String,
      imagePath: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ItemPerdido obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nomeItem)
      ..writeByte(2)
      ..write(obj.descricaoItem)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.ownerRa)
      ..writeByte(5)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemPerdidoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
