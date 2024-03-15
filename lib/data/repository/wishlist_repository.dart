import 'package:cinemax/data/datasource/wishlist_datasource.dart';
import 'package:cinemax/data/model/wishlist_cart.dart';
import 'package:dartz/dartz.dart';

abstract class WishlistRepository {
  Future<Either<String, String>> addToCart(WishlistCart cart);
  Future<Either<String, List<WishlistCart>>> showList();
  Future<Either<String, String>> deleteCard(int index);
  Future<void> deleteSelectedItem(String name);
  bool likedOnList(String name);
}

class WishlistLocalRepository extends WishlistRepository {
  final WishlistDatasource _datasource;

  WishlistLocalRepository(this._datasource);
  @override
  Future<Either<String, String>> addToCart(WishlistCart cart) async {
    try {
      await _datasource.addToWishlist(cart);
      return right("The item is successfuly added.");
    } catch (ex) {
      return left("$ex");
    }
  }

  @override
  Future<Either<String, List<WishlistCart>>> showList() async {
    try {
      var response = await _datasource.showList();
      return right(response);
    } catch (ex) {
      return left("$ex");
    }
  }

  @override
  Future<Either<String, String>> deleteCard(int index) async {
    try {
      await _datasource.deleteCart(index);
      return right("Item is deleted");
    } catch (ex) {
      return left("$ex");
    }
  }

  @override
  Future<void> deleteSelectedItem(String name) async {
    await _datasource.deleteSelectedItem(name);
  }

  @override
  bool likedOnList(String name) {
    return _datasource.likedOnList(name);
  }
}
