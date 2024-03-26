import 'package:cinemax/constants/string_constants.dart';

class Comment {
  String headline;
  String text;
  String movieID;
  String userID;
  String rate;
  bool spoiler;
  String username;
  String userThumbnail;
  String date;

  Comment(this.headline, this.text, this.movieID, this.userID, this.rate,
      this.spoiler, this.username, this.userThumbnail, this.date);

  factory Comment.withJson(Map<String, dynamic> jsonMapObject) {
    return Comment(
      jsonMapObject["headline"],
      jsonMapObject["text"],
      jsonMapObject["movie_id"],
      jsonMapObject["user_id"],
      jsonMapObject["rate"].toString(),
      jsonMapObject["spoiler"],
      jsonMapObject["expand"]["user_id"]["username"],
      "${StringConstants.baseImage}/api/files/${jsonMapObject["expand"]["user_id"]["collectionId"]}/${jsonMapObject["expand"]["user_id"]["id"]}/${jsonMapObject["expand"]["user_id"]["profile_pic"]}",
      jsonMapObject["created"],
    );
  }
}
