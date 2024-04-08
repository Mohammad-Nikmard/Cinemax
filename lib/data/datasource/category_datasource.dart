import 'package:cinemax/data/model/category.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class CategoryDatasource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDatasource extends CategoryDatasource {
  final Dio _dio;

  CategoryRemoteDatasource(this._dio);

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      var response = await _dio.get("/api/collections/categories/records");
      return response.data["items"]
          .map<CategoryModel>(
              (jsonMapObject) => CategoryModel.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 7);
    }
  }
}
