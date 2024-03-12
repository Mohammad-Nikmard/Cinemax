import 'package:cinemax/constants/string_constants.dart';

class Actors {
  String id;
  String collectionId;
  String name;
  String thumbnail;

  Actors(this.id, this.collectionId, this.name, this.thumbnail);

  factory Actors.withJson(Map<String, dynamic> jsonMapObject) {
    return Actors(
      jsonMapObject["id"],
      jsonMapObject["collectionId"],
      jsonMapObject["name"],
      "${StringConstants.baseImage}/api/files/${jsonMapObject["collectionId"]}/${jsonMapObject["id"]}/${jsonMapObject["thumbnail"]}",
    );
  }
}
