import 'package:cinemax/constants/string_constants.dart';

class UserReply {
  String id;
  String collectionId;
  String text;
  String userName;
  String date;
  String userThumbnail;
  String thumbnail;

  UserReply(this.id, this.collectionId, this.text, this.userName, this.date,
      this.userThumbnail, this.thumbnail);

  factory UserReply.withJson(Map<String, dynamic> jsonMapObject) {
    return UserReply(
      jsonMapObject["id"],
      jsonMapObject["collectionId"],
      jsonMapObject["text"],
      jsonMapObject["expand"]["user_id"]["username"],
      jsonMapObject["date"],
      "${StringConstants.baseImage}/api/files/${jsonMapObject["expand"]["user_id"]["collectionId"]}/${jsonMapObject["expand"]["user_id"]["id"]}/${jsonMapObject["expand"]["user_id"]["profile_pic"]}",
      jsonMapObject["expand"]["user_id"]["profile_pic"],
    );
  }
}
