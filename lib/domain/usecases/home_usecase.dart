import 'package:magento_app/data/remote/home_repository.dart';
import 'package:magento_app/domain/models/cms_block_response_model.dart';

class HomeUseCase {
  final HomeRepository homeRepo;

  HomeUseCase({required this.homeRepo});

  Future<CmsBlockResponse> getHomeData() async {
    return await homeRepo.getHomeData();
  }
}
