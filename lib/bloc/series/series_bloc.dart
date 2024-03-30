import 'package:cinemax/bloc/series/series_event.dart';
import 'package:cinemax/bloc/series/series_state.dart';
import 'package:cinemax/data/model/wishlist_cart.dart';
import 'package:cinemax/data/repository/comment_repository.dart';
import 'package:cinemax/data/repository/series_repository.dart';
import 'package:cinemax/data/repository/wishlist_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  final SeriesRepository _seriesRepository;
  final WishlistRepository _wishlistRepository;
  final CommentsRepository _commentsRepository;
  SeriesBloc(this._seriesRepository, this._wishlistRepository,
      this._commentsRepository)
      : super(SeriesInitState()) {
    on<SeriesDataRequestEvent>(
      (event, emit) async {
        emit(SeriesLoadingState());
        var getSeasons = await _seriesRepository.getSeasons(event.seriesId);
        var casts = await _seriesRepository.getSeriesCast(event.seriesId);
        var firstSeasonEpisode =
            await _seriesRepository.getFirstSeasonEpisode(event.seriesId);
        var isLiked = _wishlistRepository.likedOnList(event.seriesName);
        var comments = await _commentsRepository.getComments(event.seriesId);
        var photos = await _seriesRepository.getPhotos(event.seriesId);
        emit(SeriesResponseState(
            getSeasons, casts, firstSeasonEpisode, isLiked, comments, photos));
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
          event.movie.id,
        );
        await _wishlistRepository.addToCart(cart);
      },
    );
    on<WishlistDeleteItemEvent>(
      (event, emit) async {
        await _wishlistRepository.deleteSelectedItem(event.movieName);
      },
    );
    on<SeriesEpisodesFetchEvent>(
      (event, emit) async {
        var getSeasons = await _seriesRepository.getSeasons(event.seriesId);
        var casts = await _seriesRepository.getSeriesCast(event.seriesId);
        var episodes = await _seriesRepository.getEpisodes(event.seasonId);
        var isLiked = _wishlistRepository.likedOnList(event.seriesName);
        var comments = await _commentsRepository.getComments(event.seriesId);
        var photos = await _seriesRepository.getPhotos(event.seriesId);
        emit(SeriesResponseState(
            getSeasons, casts, episodes, isLiked, comments, photos));
      },
    );
    ;
  }
}
