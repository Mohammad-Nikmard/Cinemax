import 'package:cinemax/bloc/series/series_event.dart';
import 'package:cinemax/bloc/series/series_state.dart';
import 'package:cinemax/data/model/wishlist_cart.dart';
import 'package:cinemax/data/repository/series_repository.dart';
import 'package:cinemax/data/repository/wishlist_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  final SeriesRepository _seriesRepository;
  final WishlistRepository _wishlistRepository;
  SeriesBloc(this._seriesRepository, this._wishlistRepository)
      : super(SeriesInitState()) {
    on<SeriesDataRequestEvent>(
      (event, emit) async {
        emit(SeriesLoadingState());
        var getSeasons = await _seriesRepository.getSeasons(event.seriesId);
        var casts = await _seriesRepository.getSeriesCast(event.seriesId);
        emit(SeriesResponseState(getSeasons, casts));
      },
    );
    on<WishlistAddToCartEvent>(
      (event, emit) async {
        var cart = WishlistCart(
          event.movie.thumbnail,
          event.movie.name,
          event.movie.genre,
          event.movie.category,
          event.movie.rate,
        );
        await _wishlistRepository.addToCart(cart);
      },
    );
  }
}
