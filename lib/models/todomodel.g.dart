// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todomodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToDoModelAdapter extends TypeAdapter<ToDoModel> {
  @override
  final int typeId = 2;
  //read the data from database
  @override
  ToDoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToDoModel(
      id: fields[0] as String?,
      time: fields[3] as DateTime,
      title: fields[1] as String,
      date: fields[2] as DateTime,
      markAsDone: fields[4] as bool,
    );
  }
//write the data from database
  @override
  void write(BinaryWriter writer, ToDoModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.markAsDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
