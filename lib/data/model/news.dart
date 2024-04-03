import 'package:cinemax/constants/string_constants.dart';

class News {
  String id;
  String collectionId;
  String title;
  String subtitle;
  String date;
  String thumbnail;

  News(this.id, this.collectionId, this.title, this.subtitle, this.date,
      this.thumbnail);

  factory News.withJson(Map<String, dynamic> jsonMapObject) {
    return News(
      jsonMapObject["id"],
      jsonMapObject["collectionId"],
      jsonMapObject["title"],
      jsonMapObject["subtitle"],
      jsonMapObject["date"],
      "${StringConstants.baseImage}/api/files/${jsonMapObject["collectionId"]}/${jsonMapObject["id"]}/${jsonMapObject["thumbnail"]}",
    );
  }
}
