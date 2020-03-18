// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_source.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContentSourceAdapter extends TypeAdapter<ContentSource> {
  @override
  final typeId = 0;

  @override
  ContentSource read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContentSource(
      name: fields[0] as String,
      label: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ContentSource obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.label);
  }
}
