import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'en_string.dart';
import 'vi_string.dart';

const Iterable<Locale> appSupportedLocales = [
  Locale('en', 'US'),
  Locale('vi', 'VN'),
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

  static const email = 'email';
  static const password = 'password';

  static const loginButton = 'loginButton';
  static const signupButton = 'signupButton';
  static const forgetPassword = 'forgetPassword';
  static const loginToYourAccount = "loginToYourAccount";
  static const loginError = 'loginError';
  static const pressBackAgain = 'pressBackAgain';

  static const signUpTitle = 'signup.title';
  static const createAccount = 'createAccount';
  static const firstName = 'firstName';
  static const lastName = 'lastName';

  //product
  static const sortByName = 'sortByName';
  static const sortByPrice = 'sortByPrice';
  static const filter = 'filter';
  static const searchPlaceholderText = 'search.searchPlaceholderText';

  static const logOut = 'logoutButton';
  static const ok = 'ok';
  static const cancel = 'cancel';
  static const contactInformation = "contactInformation";
  static const myOrders = "myOrdersButton";
  static const myAddress = "myAddressButton";
  static const myProfile = "myProfile";

  static const changePassword = "changePassword";
  static const accountInformation = "accountInformation";
  static const editAccountInformation = "editAccountInformation";
  static const gender = "gender";
  static const dob = "dob";
  static const save = "save";
  static const telephone = "telephone";
  static const address = "address";

  static const noData = "noData";
  static const addAccountAddress = "addAccountAddress";

  static const addressDefaultBillingAddress = 'addressDefaultBillingAddress';
  static const addressDefaultShippingAddress = 'addressDefaultShippingAddress';

  static const defaultBillingAddress = 'defaultBillingAddress';
  static const defaultShippingAddress = 'defaultShippingAddress';
  static const editAddress = "editAddress";

  static const currentPassword = "currentPassword";
  static const newPassword = "newPassword";
  static const currentPasswordIncorrect = "currentPasswordIncorrect";

  static const filterByCategory = "filterByCategory";
}
