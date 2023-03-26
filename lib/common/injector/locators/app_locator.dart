import 'package:get_it/get_it.dart';
import 'package:magento_app/common/config/network/dio_config.dart';
import 'package:magento_app/common/config/network/network_info.dart';
import 'package:magento_app/data/local_repository.dart';
import 'package:magento_app/data/remote/account_repository.dart';
import 'package:magento_app/data/remote/category_repository.dart';
import 'package:magento_app/data/remote/home_repository.dart';
import 'package:magento_app/data/remote/product_repository.dart';
import 'package:magento_app/domain/usecases/account_usecase.dart';
import 'package:magento_app/domain/usecases/category_usecase.dart';
import 'package:magento_app/domain/usecases/home_usecase.dart';
import 'package:magento_app/domain/usecases/product_usecase.dart';
import 'package:magento_app/presentation/controllers/app_controller.dart';
import 'package:magento_app/presentation/journey/account/account_controller.dart';
import 'package:magento_app/presentation/journey/addresses_list/address_controller.dart';
import 'package:magento_app/presentation/journey/category/category_controller.dart';
import 'package:magento_app/presentation/journey/change_password/change_password_controller.dart';
import 'package:magento_app/presentation/journey/create_address/create_address_controller.dart';
import 'package:magento_app/presentation/journey/home/home_controller.dart';
import 'package:magento_app/presentation/journey/login/login_controller.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/journey/product/product_controller.dart';
import 'package:magento_app/presentation/journey/product_detail/product_detail_controller.dart';
import 'package:magento_app/presentation/journey/profile/profile_controller.dart';
import 'package:magento_app/presentation/journey/register/register_controller.dart';
import 'package:magento_app/presentation/journey/splash/splash_controller.dart';

GetIt getIt = GetIt.instance;

void configLocator() {
  /// Controllers
  getIt.registerLazySingleton<AppController>(() => AppController());
  getIt.registerFactory<SplashController>(
      () => SplashController(accountUseCase: getIt<AccountUseCase>()));
  getIt.registerFactory<MainController>(
      () => MainController(accountUseCase: getIt<AccountUseCase>()));
  getIt.registerFactory<HomeController>(
    () => HomeController(
      homeUseCase: getIt<HomeUseCase>(),
      productUseCase: getIt<ProductUseCase>(),
      categoryUseCase: getIt<CategoryUseCase>(),
      accountUseCase: getIt<AccountUseCase>(),
    ),
  );
  getIt.registerFactory<CategoryController>(
    () => CategoryController(
      categoryUseCase: getIt<CategoryUseCase>(),
      productUseCase: getIt<ProductUseCase>(),
    ),
  );
  getIt.registerFactory<LoginController>(
      () => LoginController(accountUsecase: getIt<AccountUseCase>()));
  getIt.registerFactory<RegisterController>(
      () => RegisterController(accountUsecase: getIt<AccountUseCase>()));
  getIt.registerFactory<ProductController>(() => ProductController(
      productUseCase: getIt<ProductUseCase>(),
      categoryUseCase: getIt<CategoryUseCase>()));
  getIt.registerFactory<AccountController>(
      () => AccountController(accountUseCase: getIt<AccountUseCase>()));
  getIt.registerFactory<ProfileController>(
      () => ProfileController(accountUsecase: getIt<AccountUseCase>()));
  getIt.registerFactory<AddressController>(() => AddressController());
  getIt.registerFactory<CreateNewAddressController>(() =>
      CreateNewAddressController(accountUsecase: getIt<AccountUseCase>()));
  getIt.registerFactory<ChangePasswordController>(
      () => ChangePasswordController(accountUsecase: getIt<AccountUseCase>()));
  getIt.registerFactory<ProductDetailController>(() => ProductDetailController(
      productUseCase: getIt<ProductUseCase>()));

  /// UseCases
  getIt.registerFactory<HomeUseCase>(
      () => HomeUseCase(homeRepo: getIt<HomeRepository>()));
  getIt.registerFactory<ProductUseCase>(
      () => ProductUseCase(productRepo: getIt<ProductRepository>()));
  getIt.registerFactory<CategoryUseCase>(
      () => CategoryUseCase(categoryRepo: getIt<CategoryRepository>()));
  getIt.registerFactory<AccountUseCase>(() => AccountUseCase(
      accountRepo: getIt<AccountRepository>(),
      localRepo: getIt<LocalRepository>()));

  /// Repositories
  getIt.registerFactory<HomeRepository>(() => HomeRepository(dio));
  getIt.registerFactory<ProductRepository>(() => ProductRepository(dio));
  getIt.registerFactory<LocalRepository>(() => LocalRepository());
  getIt.registerFactory<CategoryRepository>(() => CategoryRepository(dio));
  getIt.registerFactory<AccountRepository>(() => AccountRepository(dio));

  /// Network
  getIt.registerFactory<NetworkInfo>(() => NetworkInfoImpl());
}
