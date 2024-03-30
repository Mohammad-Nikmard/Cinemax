import 'package:hive_flutter/hive_flutter.dart';
part 'wishlist_cart.g.dart';

@HiveType(typeId: 0)
class WishlistCart {
  @HiveField(0)
  String thumbnail;
  @HiveField(1)
  String name;
  @HiveField(2)
  String genre;
  @HiveField(3)
  String category;
  @HiveField(4)
  String rate;
  @HiveField(5)
  String movieId;

  WishlistCart(this.thumbnail, this.name, this.genre, this.category, this.rate,
      this.movieId);
}
