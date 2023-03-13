import 'package:get_it/get_it.dart';
import 'package:magento_app/common/config/network/dio_config.dart';
import 'package:magento_app/common/config/network/network_info.dart';
import 'package:magento_app/data/local_repository.dart';
import 'package:magento_app/data/remote/home_repository.dart';
import 'package:magento_app/data/remote/product_repository.dart';
import 'package:magento_app/domain/usecases/home_usecase.dart';
import 'package:magento_app/domain/usecases/product_usecase.dart';
import 'package:magento_app/presentation/controllers/app_controller.dart';
import 'package:magento_app/presentation/journey/home/home_controller.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/journey/splash/splash_controller.dart';

GetIt getIt = GetIt.instance;

void configLocator() {
  /// Controllers
  getIt.registerLazySingleton<AppController>(() => AppController());
  getIt.registerFactory<SplashController>(() => SplashController());
  getIt.registerFactory<MainController>(() => MainController());
  getIt.registerFactory<HomeController>(
    () => HomeController(
      homeUseCase: getIt<HomeUseCase>(),
      productUseCase: getIt<ProductUseCase>(),
    ),
  );

  /// UseCases
  getIt.registerFactory<HomeUseCase>(
      () => HomeUseCase(homeRepo: getIt<HomeRepository>()));
  getIt.registerFactory<ProductUseCase>(
      () => ProductUseCase(productRepo: getIt<ProductRepository>()));

  /// Repositories
  getIt.registerFactory<HomeRepository>(() => HomeRepository(dio));
  getIt.registerFactory<ProductRepository>(() => ProductRepository(dio));
  getIt.registerFactory<LocalRepository>(() => LocalRepository());

  /// Network
  getIt.registerFactory<NetworkInfo>(() => NetworkInfoImpl());
}
