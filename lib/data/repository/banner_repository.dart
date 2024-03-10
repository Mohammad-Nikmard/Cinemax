import 'package:cinemax/data/datasource/banner_datasource.dart';
import 'package:cinemax/data/model/banner.dart';
import 'package:cinemax/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class BannerRepository {
  Future<Either<String, List<BannerModel>>> getBanner();
}

class BannerRemoteRepository extends BannerRepository {
  final BannerDatasource _bannerDatasource;

  BannerRemoteRepository(this._bannerDatasource);

  @override
  Future<Either<String, List<BannerModel>>> getBanner() async {
    try {
      var response = await _bannerDatasource.getBanners();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message);
    } catch (ex) {
      return left("$ex");
    }
  }
}
