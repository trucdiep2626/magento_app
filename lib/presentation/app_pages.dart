import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/common/injector/bindings/account_binding.dart';
import 'package:magento_app/common/injector/bindings/addresses_list_binding.dart';
import 'package:magento_app/common/injector/bindings/category_binding.dart';
import 'package:magento_app/common/injector/bindings/create_address_binding.dart';
import 'package:magento_app/common/injector/bindings/home_binding.dart';
import 'package:magento_app/common/injector/bindings/login_binding.dart';
import 'package:magento_app/common/injector/bindings/product_binding.dart';
import 'package:magento_app/common/injector/bindings/profile_binding.dart';
import 'package:magento_app/common/injector/bindings/register_binding.dart';
import 'package:magento_app/presentation/journey/addresses_list/address_screen.dart';
import 'package:magento_app/presentation/journey/create_address/create_address_screen.dart';
import 'package:magento_app/presentation/journey/login/login_screen.dart';
import 'package:magento_app/presentation/journey/product/product_screen.dart';
import 'package:magento_app/presentation/journey/profile/profile_screen.dart';
import 'package:magento_app/presentation/journey/register/register_screen.dart';
import 'journey/main/main_screen.dart';
import 'journey/splash/splash_screen.dart';

List<GetPage> myPages = [
  GetPage(
    name: AppRoutes.splash,
    page: () => const SplashScreen(),
    binding: SplashBinding(),
  ),
  GetPage(name: AppRoutes.main, page: () => MainScreen(), bindings: [
    MainBinding(),
    HomeBinding(),
    CategoryBinding(),
    ProductBinding(),
    AccountBinding(),
  ]),
  GetPage(
    name: AppRoutes.login,
    page: () => const LogInScreen(),
    binding: LoginBinding(),
  ),
  GetPage(
    name: AppRoutes.register,
    page: () => RegisterScreen(),
    binding: RegisterBinding(),
  ),
  GetPage(
    name: AppRoutes.product,
    page: () => ProductScreen(),
    binding: ProductBinding(),
  ),
  GetPage(
    name: AppRoutes.profile,
    page: () => ProfileScreen(),
    binding: ProfileBinding(),
  ),
  GetPage(
    name: AppRoutes.address,
    page: () => AddressScreen(),
    binding: AddressBinding(),
  ),
  GetPage(
    name: AppRoutes.createAddress,
    page: () => CreateNewAddressScreen(),
    binding: CreateAddressBinding(),
  ),
];
