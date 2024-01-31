// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceAdapter extends TypeAdapter<Service> {
  @override
  final int typeId = 3;

  @override
  Service read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Service(
      fields[0] as int,
      fields[1] as int,
      fields[2] as String,
      fields[3] as int,
      fields[4] as double,
      fields[5] as double,
      fields[6] as double,
      fields[7] as int,
      fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Service obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.serviceId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.tariffLinkId)
      ..writeByte(4)
      ..write(obj.costWithTaxes)
      ..writeByte(5)
      ..write(obj.cost)
      ..writeByte(6)
      ..write(obj.costCoef)
      ..writeByte(7)
      ..write(obj.discountPeriodStart)
      ..writeByte(8)
      ..write(obj.discountPeriodEnd);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
