import 'package:magento_app/data/remote/product_repository.dart';
import 'package:magento_app/domain/models/products_response_model.dart';

class ProductUseCase {
  final ProductRepository productRepo;

  ProductUseCase({required this.productRepo});

  Future<ProductsResponseModel?> getProductsWithAttribute(
      {int pageSize = 10,
      int currentPage = 1,
      String? conditionType,
      String? attributeCode,
      String? attributeValue,
      String? fields}) async {
    return await productRepo.getProductsWithAttribute(
      pageSize: pageSize,
      currentPage: currentPage,
      conditionType: conditionType,
      attributeCode: attributeCode,
      attributeValue: attributeValue,
      fields: fields,
    );
  }
}
