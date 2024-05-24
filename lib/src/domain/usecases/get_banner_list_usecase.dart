import 'package:edspert/src/domain/repositories/banner_repository.dart';

import '../../data/models/banner_model.dart';

class GetBannerListUsecase {
  final BannerRepository repository;

  GetBannerListUsecase(this.repository);
  
  Future<List<BannerData>?> call() {
    return repository.getBannerList();
  }
}
