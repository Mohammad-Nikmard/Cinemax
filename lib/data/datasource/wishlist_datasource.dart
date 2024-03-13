import 'package:cinemax/data/model/wishlist_cart.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class WishlistDatasource {
  Future<void> addToWishlist(WishlistCart cart);
  Future<List<WishlistCart>> showList();
  Future<void> deleteCart(int index);
  Future<void> deleteSelectedItem(String name);
}

class WishlistLocalDatasource extends WishlistDatasource {
  var box = Hive.box<WishlistCart>("MovieBox");

  @override
  Future<void> addToWishlist(WishlistCart cart) async {
    await box.add(cart);
  }

  @override
  Future<List<WishlistCart>> showList() async {
    return box.values.toList();
  }

  @override
  Future<void> deleteCart(int index) async {
    await box.deleteAt(index);
  }

  @override
  Future<void> deleteSelectedItem(String name) async {
    var list = box.values.toList();

    var item = list.indexWhere((element) => element.name.contains(name));

    box.deleteAt(item);
  }
}
