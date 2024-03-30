import 'package:cinemax/constants/string_constants.dart';

class VideoModel {
  String id;
  String collectionId;
  String movieID;
  String trailer;
  String name;

  VideoModel(this.collectionId, this.id, this.movieID, this.trailer, this.name);

  factory VideoModel.withJson(Map<String, dynamic> jsonMapObject) {
    return VideoModel(
      jsonMapObject["id"],
      jsonMapObject["collectionId"],
      jsonMapObject["movie_id"],
      "${StringConstants.baseImage}/api/files/${jsonMapObject["collectionId"]}/${jsonMapObject["id"]}/${jsonMapObject["trailer"]}",
      jsonMapObject["name"],
    );
  }
}
