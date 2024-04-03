import 'package:cinemax/bloc/news/news_event.dart';
import 'package:cinemax/bloc/news/news_state.dart';
import 'package:cinemax/data/repository/news_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepository;
  NewsBloc(this._newsRepository) : super(NewsInitState()) {
    on<FetchNewsEvent>(
      (event, emit) async {
        emit(NewsLoadingState());
        var news = await _newsRepository.getNews();
        emit(NewsResponseState(news));
      },
    );
  }
}
