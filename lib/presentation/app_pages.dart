import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/common/injector/bindings/home_binding.dart';

import 'journey/main/main_screen.dart';
import 'journey/splash/splash_screen.dart';

List<GetPage> myPages = [
  GetPage(name: AppRoutes.splash, page: () => const SplashScreen(), binding: SplashBinding()),
  GetPage(name: AppRoutes.main, page: () =>   MainScreen(), bindings: [
    MainBinding(),
    HomeBinding(),
  ]),
];
