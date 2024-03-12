abstract class WishlistEvent {}

class WishlistFetchCartsEvent extends WishlistEvent {}

class WishlistCardDelete extends WishlistEvent {
  int index;

  WishlistCardDelete(this.index);
}
