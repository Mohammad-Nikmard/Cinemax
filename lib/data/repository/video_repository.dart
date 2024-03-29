import 'package:cinemax/data/datasource/video_datasource.dart';
import 'package:cinemax/data/model/video.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class VideoRepository {
  Future<Either<String, VideoModel>> getVideo(String movieID);
}

class VideoRemoteRepository extends VideoRepository {
  final VideoDatasource _datasource;

  VideoRemoteRepository(this._datasource);
  @override
  Future<Either<String, VideoModel>> getVideo(String movieID) async {
    try {
      var response = await _datasource.getVideo(movieID);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    }
  }
}
