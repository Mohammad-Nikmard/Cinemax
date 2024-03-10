import 'package:cinemax/constants/string_constants.dart';

class BannerModel {
  String id;
  String collectionId;
  String title;
  String relaseMonth;
  String releaseDate;
  String relaseYear;
  String thumbnail;

  BannerModel(this.id, this.collectionId, this.title, this.relaseMonth,
      this.releaseDate, this.relaseYear, this.thumbnail);

  factory BannerModel.withJson(Map<String, dynamic> jsonMapObject) {
    return BannerModel(
      jsonMapObject["id"],
      jsonMapObject["collectionId"],
      jsonMapObject["movie_name"],
      jsonMapObject["release_month"],
      jsonMapObject["release_date"].toString(),
      jsonMapObject["realse_year"].toString(),
      "${StringConstants.baseImage}/api/files/${jsonMapObject["collectionId"]}/${jsonMapObject["id"]}/${jsonMapObject["thumbnail"]}",
    );
  }
}
