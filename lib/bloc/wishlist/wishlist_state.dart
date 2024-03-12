import 'package:cinemax/data/model/wishlist_cart.dart';
import 'package:dartz/dartz.dart';

abstract class WishlistState {}

class WishlistInitState extends WishlistState {}

class WishlistLoadingState extends WishlistState {}

class WishlistResponseState extends WishlistState {
  Either<String, List<WishlistCart>> getCards;

  WishlistResponseState(this.getCards);
}

class WishlistEmptyState extends WishlistState {}
