import 'package:cinemax/data/model/banner.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class BannerDatasource {
  Future<List<BannerModel>> getBanners();
}

class BannerRemoteDatasource extends BannerDatasource {
  final Dio _dio;

  BannerRemoteDatasource(this._dio);
  @override
  Future<List<BannerModel>> getBanners() async {
    try {
      var response = await _dio.get("/api/collections/banner/records");
      return response.data["items"]
          .map<BannerModel>(
              (jsonMapObject) => BannerModel.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 0);
    }
  }
}
