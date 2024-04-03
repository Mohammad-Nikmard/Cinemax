import 'package:cinemax/data/model/news.dart';
import 'package:dartz/dartz.dart';

abstract class NewsState {}

class NewsInitState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsResponseState extends NewsState {
  Either<String, List<News>> getNews;

  NewsResponseState(this.getNews);
}
