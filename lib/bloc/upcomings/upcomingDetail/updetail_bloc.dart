import 'package:cinemax/bloc/upcomings/upcomingDetail/updetail_event.dart';
import 'package:cinemax/bloc/upcomings/upcomingDetail/updetail_state.dart';
import 'package:cinemax/data/model/wishlist_cart.dart';
import 'package:cinemax/data/repository/upcomings_repository.dart';
import 'package:cinemax/data/repository/wishlist_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpDetailBloc extends Bloc<UpDetailEvent, UpDetailState> {
  final UpcomingsRepository _upcomingsRepository;
  final WishlistRepository _wishlistRepository;

  UpDetailBloc(this._upcomingsRepository, this._wishlistRepository)
      : super(UpDetailInitState()) {
    on<UpDetailDataRequestEvent>(
      (event, emit) async {
        emit(UpDetailLoadingState());
        var getphotos = await _upcomingsRepository.getPhotos(event.upId);
        var casts = await _upcomingsRepository.getCasts(event.upId);
        var isOnLikes = _wishlistRepository.likedOnList(event.upName);
        emit(UpDetailResponseState(getphotos, casts, isOnLikes));
      },
    );
    on<UpcomingAddToCartEvent>(
      (event, emit) async {
        var cart = WishlistCart(
          event.upcoimngItem.thumbnail,
          event.upcoimngItem.name,
          event.upcoimngItem.genre,
          "Upcomings",
          "",
          event.upcoimngItem.id,
        );
        await _wishlistRepository.addToCart(cart);
      },
    );

    on<DeleteWishlistItemEvent>(
      (event, emit) async {
        await _wishlistRepository.deleteSelectedItem(event.movieName);
      },
    );
  }
}
