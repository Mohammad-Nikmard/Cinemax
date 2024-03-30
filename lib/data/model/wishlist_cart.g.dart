// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_cart.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WishlistCartAdapter extends TypeAdapter<WishlistCart> {
  @override
  final int typeId = 0;

  @override
  WishlistCart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WishlistCart(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WishlistCart obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.thumbnail)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.genre)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.rate)
      ..writeByte(5)
      ..write(obj.movieId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishlistCartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
