import 'package:cinemax/constants/string_constants.dart';

class Episode {
  String id;
  String collectionId;
  String timeLength;
  String description;
  String rate;
  String thumbnail;
  String episodeNum;
  String seasonId;

  Episode(this.id, this.collectionId, this.timeLength, this.description,
      this.rate, this.thumbnail, this.episodeNum, this.seasonId);

  factory Episode.withJson(Map<String, dynamic> jsonMapObject) {
    return Episode(
      jsonMapObject["id"],
      jsonMapObject["collectionId"],
      jsonMapObject["timelength"],
      jsonMapObject["description"],
      jsonMapObject["rate"],
      "${StringConstants.baseImage}/api/files/${jsonMapObject["collectionId"]}/${jsonMapObject["id"]}/${jsonMapObject["thumbnail"]}",
      jsonMapObject["episode_number"].toString(),
      jsonMapObject["season_id"],
    );
  }
}
