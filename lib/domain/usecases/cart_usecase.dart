import 'package:magento_app/data/local_repository.dart';
import 'package:magento_app/data/remote/account_repository.dart';
import 'package:magento_app/data/remote/cart_repository.dart';
import 'package:magento_app/domain/models/cart_information_model.dart';
import 'package:magento_app/domain/models/customer_model.dart';
import 'package:magento_app/domain/models/estimate_shipping_methods_model.dart';
import 'package:magento_app/domain/models/save_shipping_method_response_model.dart';

class CartUseCase {
  final CartRepository cartRepo;
  final LocalRepository localRepo;

  CartUseCase({required this.cartRepo, required this.localRepo});

  String? getToken() {
    return localRepo.getToken();
  }

  Future<CartInformationModel?> getCartInfor() async {
    String? token = getToken();

    return token == null ? null : (await cartRepo.getCartInfor(token));
  }

  Future<int?> createCart() async {
    String? token = getToken();

    return token == null ? null : (await cartRepo.createCart(token));
  }

  Future<bool> addToCart({
    required String sku,
    required int qty,
    required String image,
  }) async {
    String? token = getToken();

    return token == null
        ? false
        : (await cartRepo.addToCart(
            sku: sku,
            qty: qty,
            token: token,
            image: image,
          ));
  }

  Future<List<CartItem>?> getCartItems() async {
    String? token = getToken();

    return token == null ? null : (await cartRepo.getCartItems(token));
  }

  Future<bool> deleteItem({required String itemId}) async {
    String? token = getToken();

    return token == null
        ? false
        : (await cartRepo.deleteItem(
            token: token,
            itemId: itemId,
          ));
  }

  Future<List<EstimateShippingMethodsModel>> getEstimateShippingMethods(
      {required int addressId}) async {
    String? token = getToken();

    return token == null
        ? []
        : await cartRepo.getEstimateShippingMethods(
            token: token,
            addressId: addressId,
          );
  }

  Future<SaveShippingMethodResponseModel?> addShippingInformation(
      {required EstimateShippingMethodsModel shippingMethod,
      required CustomerModel customer,
      required Addresses address}) async {
    String? token = getToken();

    return token == null
        ? null
        : await cartRepo.addShippingInformation(
            token: token,
            address: address,
            customer: customer,
            shippingMethod: shippingMethod,
          );
  }

  Future<int?> createOrder({
    required String token,
    required PaymentMethods payment,
    required CustomerModel customer,
    required Addresses address,
  }) async {
    String? token = getToken();

    return token == null
        ? null
        : await cartRepo.createOrder(
            token: token,
            address: address,
            customer: customer,
            payment: payment,
          );
  }
}
