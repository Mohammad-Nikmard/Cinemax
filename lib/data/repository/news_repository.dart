import 'package:cinemax/data/datasource/news_datasource.dart';
import 'package:cinemax/data/model/news.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class NewsRepository {
  Future<Either<String, List<News>>> getNews();
}

class NewsRemoteRpositry extends NewsRepository {
  final NewsDatasource _datasource;

  NewsRemoteRpositry(this._datasource);

  @override
  Future<Either<String, List<News>>> getNews() async {
    try {
      var response = await _datasource.getNews();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }
}
