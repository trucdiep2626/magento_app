import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'en_string.dart';
import 'vi_string.dart';

const Iterable<Locale> appSupportedLocales = [
  Locale('vi', 'VN'),
  Locale('en', 'US')
];

class AppTranslations extends Translations {
  static const String localeCodeVi = 'vi_VN';
  static const String localeCodeEn = 'en_US';

  @override
  Map<String, Map<String, String>> get keys => {
        localeCodeVi: viString,
        localeCodeEn: enString,
      };

  static String unknownError = 'unknownError';
  static String noConnectionError = 'noConnectionError';
}

class TransactionConstants {
  static const unknownError = 'unknownError';
  static const noConnectionError = 'noConnectionError';
  static const mainNavigationHome = 'main.navigation.home';
  static const mainNavigationCategory = 'main.navigation.category';
  static const mainNavigationMalls = 'main.navigation.malls';
  static const mainNavigationCart = 'main.navigation.cart';
  static const mainNavigationAccount = 'main.navigation.account';

  static const homeLookingfor = 'home.lookingfor';
  static const shirt = 'shirt';
  static const pants = 'pants';
  static const coats = 'coats';
  static const bags = 'bags';
  static const shoes = 'shoes';
  static const accessories = 'accessories';

  static const hotItems = 'hotItems';

  static const addToCartButton = 'addToCartButton';

  static const men = 'men';
  static const women = 'women';
  static const sale = 'sale';
  static const gear = 'gear';
  static const viewAll = 'viewAll';
  static const subCategories = 'subCategories';
  static const mainMenu = 'mainMenu';

  static const accountTitle = 'account.title';

  static const loginTitle = 'login.title';
}
