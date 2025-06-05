// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_frame.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeFrameAdapter extends TypeAdapter<TimeFrame> {
  @override
  final typeId = 0;

  @override
  TimeFrame read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeFrame(fields[0] as DateTime, fields[1] as DateTime?);
  }

  @override
  void write(BinaryWriter writer, TimeFrame obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.start)
      ..writeByte(1)
      ..write(obj.end);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeFrameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
