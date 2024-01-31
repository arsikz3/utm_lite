// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_app.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsAppAdapter extends TypeAdapter<SettingsApp> {
  @override
  final int typeId = 1;

  @override
  SettingsApp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsApp(
      portServer: fields[0] as String,
      serverIP: fields[1] as String,
      darkTheme: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsApp obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.portServer)
      ..writeByte(1)
      ..write(obj.serverIP)
      ..writeByte(2)
      ..write(obj.darkTheme);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsAppAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
