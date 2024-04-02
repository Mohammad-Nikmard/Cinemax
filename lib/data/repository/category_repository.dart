import 'package:cinemax/data/datasource/category_datasource.dart';
import 'package:cinemax/data/model/category.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository {
  Future<Either<String, List<CategoryModel>>> getCategories();
}

class CategoryRemoteRepositry extends CategoryRepository {
  final CategoryDatasource _datasource;

  CategoryRemoteRepositry(this._datasource);

  @override
  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      var response = await _datasource.getCategories();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }
}
