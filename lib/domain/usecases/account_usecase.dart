import 'package:magento_app/data/local_repository.dart';
import 'package:magento_app/data/remote/account_repository.dart';
import 'package:magento_app/domain/models/customer_model.dart';

class AccountUseCase {
  final AccountRepository accountRepo;
  final LocalRepository localRepo;

  AccountUseCase({required this.accountRepo, required this.localRepo});

  Future<String?> login({
    required String username,
    required String password,
  }) async {
    return await accountRepo.login(username: username, password: password);
  }

  Future<void> saveToken(String token) async {
    await localRepo.saveToken(token);
  }

  String? getToken() {
    return localRepo.getToken();
  }

  Future<void> saveCustomerInformation(CustomerModel customerModel) async {
    await localRepo.saveCustomerInformation(customerModel);
  }

  CustomerModel? getCustomerInformationLocal() {
    return localRepo.getCustomerInformation();
  }

  Future<CustomerModel?> getCustomerInformation() async {
    String? token = getToken();

    return token == null ? null : await accountRepo.getCustomerInfor(token);
  }

  Future<void> saveEmail(String email) async {
    await localRepo.saveEmail(email);
  }

  Future<void> savePass(String password) async {
    await localRepo.savePass(password);
  }

  Future<String?> getSecureData(String key) async {
    return localRepo.getSecureData(key);
  }

  Future<bool> register({
    required String username,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    return accountRepo.register(
      username: username,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
  }
}
