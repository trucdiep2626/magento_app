import 'package:magento_app/data/remote/product_repository.dart';
import 'package:magento_app/domain/models/products_response_model.dart';

class ProductUseCase {
  final ProductRepository productRepo;

  ProductUseCase({required this.productRepo});

  Future<ProductsResponseModel> getProductsWithAttribute(
      {int currentPage = 1}) async {
    return await productRepo.getProductsWithAttribute(currentPage: currentPage);
  }
}
