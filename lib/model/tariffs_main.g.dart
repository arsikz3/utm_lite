// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tariffs_main.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MainTariffAdapter extends TypeAdapter<MainTariff> {
  @override
  final int typeId = 4;

  @override
  MainTariff read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MainTariff(
      id: fields[0] as int,
      name: fields[1] as String,
      nextTariffName: fields[2] as String,
      tariffLinkId: fields[3] as int,
      accountId: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MainTariff obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.nextTariffName)
      ..writeByte(3)
      ..write(obj.tariffLinkId)
      ..writeByte(4)
      ..write(obj.accountId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainTariffAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
