import 'package:edspert/src/data/data_source/banner_data_source.dart';

import '../../domain/repositories/banner_repository.dart';
import '../models/banner_model.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerDataSource bannerDataSource;

  BannerRepositoryImpl(this.bannerDataSource);

  @override
  Future<List<BannerData>?> getBannerList() async {
    return bannerDataSource.getBannerList();
  }
}
