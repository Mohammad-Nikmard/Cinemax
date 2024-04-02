import 'package:cinemax/constants/string_constants.dart';

class CategoryModel {
  String id;
  String collectionId;
  String name;
  String thumbnail;

  CategoryModel(this.id, this.collectionId, this.name, this.thumbnail);

  factory CategoryModel.withJson(Map<String, dynamic> jsonMapObject) {
    return CategoryModel(
      jsonMapObject["id"],
      jsonMapObject["collectionId"],
      jsonMapObject["name"],
      "${StringConstants.baseImage}/api/files/${jsonMapObject["collectionId"]}/${jsonMapObject["id"]}/${jsonMapObject["category_pic"]}",
    );
  }
}
