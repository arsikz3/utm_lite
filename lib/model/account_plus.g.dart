// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_plus.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountPlusAdapter extends TypeAdapter<AccountPlus> {
  @override
  final int typeId = 2;

  @override
  AccountPlus read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountPlus(
      fields[0] as int,
      fields[1] as double,
      fields[2] as double,
      fields[3] as int,
      fields[4] as int,
      fields[5] as String,
      (fields[6] as List).cast<Service>(),
      (fields[7] as List).cast<AccountTariff>(),
      fields[8] as int,
      fields[9] as int,
      fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AccountPlus obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.credit)
      ..writeByte(2)
      ..write(obj.balance)
      ..writeByte(3)
      ..write(obj.intStatus)
      ..writeByte(4)
      ..write(obj.vatRate)
      ..writeByte(5)
      ..write(obj.externalId)
      ..writeByte(6)
      ..write(obj.services)
      ..writeByte(7)
      ..write(obj.tariffs)
      ..writeByte(8)
      ..write(obj.blockId)
      ..writeByte(9)
      ..write(obj.blockType)
      ..writeByte(10)
      ..write(obj.actualDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountPlusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
