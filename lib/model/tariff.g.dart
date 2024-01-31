// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tariff.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountTariffAdapter extends TypeAdapter<AccountTariff> {
  @override
  final int typeId = 5;

  @override
  AccountTariff read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountTariff(
      fields[0] as int,
      fields[1] as int,
      fields[2] as String,
      fields[3] as String,
      fields[4] as int,
      fields[5] as String,
      fields[6] as String,
      fields[7] as int,
      fields[8] as int,
      fields[9] as int,
      fields[10] as int,
      fields[11] as int,
      fields[12] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AccountTariff obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.accountId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.nextTariffName)
      ..writeByte(4)
      ..write(obj.tariffLinkId)
      ..writeByte(5)
      ..write(obj.currentTariffComment)
      ..writeByte(6)
      ..write(obj.nextTariffComment)
      ..writeByte(7)
      ..write(obj.currentTariffCreateDate)
      ..writeByte(8)
      ..write(obj.currentTariffChangeDate)
      ..writeByte(9)
      ..write(obj.currentTariffExpireDate)
      ..writeByte(10)
      ..write(obj.nextTariffCreateDate)
      ..writeByte(11)
      ..write(obj.nextTariffChangeDate)
      ..writeByte(12)
      ..write(obj.nextTariffExpireDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountTariffAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
