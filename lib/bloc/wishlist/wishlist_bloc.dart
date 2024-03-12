import 'package:cinemax/bloc/wishlist/wishlist_event.dart';
import 'package:cinemax/bloc/wishlist/wishlist_state.dart';
import 'package:cinemax/data/repository/wishlist_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistRepository _wishlistrepository;
  WishlistBloc(this._wishlistrepository) : super(WishlistInitState()) {
    on<WishlistFetchCartsEvent>(
      (event, emit) async {
        emit(WishlistLoadingState());
        var cart = await _wishlistrepository.showList();
        cart.fold(
          (l) {},
          (list) {
            if (list.isEmpty) {
              emit(WishlistEmptyState());
            } else if (list.isNotEmpty) {
              emit(WishlistResponseState(cart));
            }
          },
        );
      },
    );
    on<WishlistCardDelete>(
      (event, emit) async {
        await _wishlistrepository.deleteCard(event.index);
        var cart = await _wishlistrepository.showList();
        cart.fold(
          (l) {},
          (list) {
            if (list.isEmpty) {
              emit(WishlistEmptyState());
            } else if (list.isNotEmpty) {
              emit(WishlistResponseState(cart));
            }
          },
        );
      },
    );
  }
}
