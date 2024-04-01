import 'package:cinemax/data/model/upcomings.dart';

abstract class UpDetailEvent {}

class UpDetailDataRequestEvent extends UpDetailEvent {
  String upId;
  String upName;

  UpDetailDataRequestEvent(this.upId, this.upName);
}

class DeleteWishlistItemEvent extends UpDetailEvent {
  String movieName;

  DeleteWishlistItemEvent(this.movieName);
}

class UpcomingAddToCartEvent extends UpDetailEvent {
  final Upcomings upcoimngItem;

  UpcomingAddToCartEvent(this.upcoimngItem);
}
