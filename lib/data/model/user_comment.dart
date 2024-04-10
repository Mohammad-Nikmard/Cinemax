import 'package:cinemax/constants/string_constants.dart';

class UserComment {
  String id;
  String collectionId;
  String movieID;
  String time;
  String headline;
  String text;
  String rate;
  String movieName;
  String movieGenre;
  String movieThumbnail;

  UserComment(
    this.id,
    this.collectionId,
    this.movieID,
    this.time,
    this.headline,
    this.text,
    this.rate,
    this.movieName,
    this.movieGenre,
    this.movieThumbnail,
  );

  factory UserComment.withJson(Map<String, dynamic> jsonMapObject) {
    return UserComment(
      jsonMapObject["id"],
      jsonMapObject["collectionId"],
      jsonMapObject["movie_id"],
      jsonMapObject["time"],
      jsonMapObject["headline"],
      jsonMapObject["text"],
      jsonMapObject["rate"].toString(),
      jsonMapObject["expand"]["movie_id"]["name"],
      jsonMapObject["expand"]["movie_id"]["genre"],
      "${StringConstants.baseImage}/api/files/${jsonMapObject["expand"]["movie_id"]["collectionId"]}/${jsonMapObject["expand"]["movie_id"]["id"]}/${jsonMapObject["expand"]["movie_id"]["thumbnail"]}",
    );
  }
}
