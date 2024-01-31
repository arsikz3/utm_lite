// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int,
      login: fields[1] as String,
      password: fields[2] as String,
      actualAddress: fields[3] as String,
      fullname: fields[4] as String,
      email: fields[5] as String,
      homeTelephone: fields[6] as String,
      mobileTelephone: fields[7] as String,
      created: fields[8] as String,
      memo: fields[9] as String,
      token: fields[10] as String,
      isactive: fields[11] as bool,
      basicAccount: fields[12] as int,
      balance: fields[13] as double,
      credit: fields[14] as double,
      paymentInMonth: fields[15] as double,
      tariffs: (fields[16] as List).cast<MainTariff>(),
      accounts: (fields[17] as List).cast<AccountPlus>(),
      groups: (fields[18] as List).cast<dynamic>(),
      encrypted: fields[19] as int,
      isJuridical: fields[20] as int,
      isSendKeepAlive: fields[21] as bool,
      hotspotLogin: fields[22] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(23)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.login)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.actualAddress)
      ..writeByte(4)
      ..write(obj.fullname)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.homeTelephone)
      ..writeByte(7)
      ..write(obj.mobileTelephone)
      ..writeByte(8)
      ..write(obj.created)
      ..writeByte(9)
      ..write(obj.memo)
      ..writeByte(10)
      ..write(obj.token)
      ..writeByte(11)
      ..write(obj.isactive)
      ..writeByte(12)
      ..write(obj.basicAccount)
      ..writeByte(13)
      ..write(obj.balance)
      ..writeByte(14)
      ..write(obj.credit)
      ..writeByte(15)
      ..write(obj.paymentInMonth)
      ..writeByte(16)
      ..write(obj.tariffs)
      ..writeByte(17)
      ..write(obj.accounts)
      ..writeByte(18)
      ..write(obj.groups)
      ..writeByte(19)
      ..write(obj.encrypted)
      ..writeByte(20)
      ..write(obj.isJuridical)
      ..writeByte(21)
      ..write(obj.isSendKeepAlive)
      ..writeByte(22)
      ..write(obj.hotspotLogin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
