// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeModelAdapter extends TypeAdapter<HomeModel> {
  @override
  final int typeId = 1;

  @override
  HomeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomeModel(
      id: fields[0] as String,
      name: fields[1] as String,
      place: fields[2] as String,
      number: fields[3] as String,
      age: fields[4] as String,
      image: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HomeModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.place)
      ..writeByte(3)
      ..write(obj.number)
      ..writeByte(4)
      ..write(obj.age)
      ..writeByte(6)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
