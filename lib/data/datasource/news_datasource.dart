import 'package:cinemax/data/model/news.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class NewsDatasource {
  Future<List<News>> getNews();
}

class NewsRemoteDatasource extends NewsDatasource {
  final Dio _dio;

  NewsRemoteDatasource(this._dio);

  @override
  Future<List<News>> getNews() async {
    try {
      var response = await _dio.get("/api/collections/news/records");
      return response.data["items"]
          .map<News>((jsonMapObject) => News.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 19);
    }
  }
}
