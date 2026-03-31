// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieModelAdapter extends TypeAdapter<MovieModel> {
  @override
  final int typeId = 0;

  @override
  MovieModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieModel(
      id: fields[0] as int,
      title: fields[1] as String,
      year: fields[2] as int,
      rating: fields[3] as double,
      summary: fields[4] as String,
      mediumCoverImage: fields[5] as String,
      genres: (fields[7] as List).cast<String>(),
      runtime: fields[8] as int,
      largeCoverImage: fields[6] as String,
      language: fields[9] as String,
      url: fields[10] as String?,
      likeCount: fields[11] as int?,
      cast: (fields[12] as List?)?.cast<CastModel>(),
      screenshots: (fields[13] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, MovieModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.year)
      ..writeByte(3)
      ..write(obj.rating)
      ..writeByte(4)
      ..write(obj.summary)
      ..writeByte(5)
      ..write(obj.mediumCoverImage)
      ..writeByte(6)
      ..write(obj.largeCoverImage)
      ..writeByte(7)
      ..write(obj.genres)
      ..writeByte(8)
      ..write(obj.runtime)
      ..writeByte(9)
      ..write(obj.language)
      ..writeByte(10)
      ..write(obj.url)
      ..writeByte(11)
      ..write(obj.likeCount)
      ..writeByte(12)
      ..write(obj.cast)
      ..writeByte(13)
      ..write(obj.screenshots);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CastModelAdapter extends TypeAdapter<CastModel> {
  @override
  final int typeId = 1;

  @override
  CastModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CastModel(
      name: fields[0] as String,
      characterName: fields[1] as String,
      urlCastImage: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CastModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.characterName)
      ..writeByte(2)
      ..write(obj.urlCastImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CastModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
