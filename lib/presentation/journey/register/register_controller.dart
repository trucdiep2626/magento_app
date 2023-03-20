import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/common/utils/app_validator.dart';
import 'package:magento_app/domain/usecases/account_usecase.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class RegisterController extends GetxController with MixinController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final firstNameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();

  //RxString errorText = ''.obs;

  RxString emailValidate = ''.obs;
  RxString passwordValidate = ''.obs;
  RxString firstNameValidate = ''.obs;
  RxString lastNameValidate = ''.obs;

  RxBool emailHasFocus = false.obs;
  RxBool pwdHasFocus = false.obs;
  RxBool firstNameHasFocus = false.obs;
  RxBool lastNameHasFocus = false.obs;

  RxBool buttonEnable = false.obs;

  Rx<LoadedType> rxLoadedButton = LoadedType.finish.obs;
  AccountUseCase accountUsecase;

  //final mainController = Get.find<MainController>();

  RegisterController({required this.accountUsecase});

  void checkButtonEnable() {
    if (emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty &&
        lastNameController.text.trim().isNotEmpty &&
        firstNameController.text.trim().isNotEmpty) {
      buttonEnable.value = true;
    } else {
      buttonEnable.value = false;
    }
  }

  void postRegister() async {
    rxLoadedButton.value = LoadedType.start;
    hideKeyboard();
    // errorText.value = '';
    emailValidate.value = AppValidator.validateEmail(emailController);
    passwordValidate.value = AppValidator.validatePassword(passwordController);
    firstNameValidate.value = AppValidator.validateName(
      TransactionConstants.firstName.tr,
      firstNameController,
    );
    lastNameValidate.value = AppValidator.validateName(
      TransactionConstants.lastName.tr,
      lastNameController,
    );

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      rxLoadedButton.value = LoadedType.finish;
      return;
    }

    if (emailValidate.value.isEmpty &&
        passwordValidate.value.isEmpty &&
        firstNameValidate.value.isEmpty &&
        lastNameValidate.value.isEmpty) {
      final result = await accountUsecase.register(
        username: emailController.text.trim(),
        password: passwordController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
      );

      if (result) {
        debugPrint('đăng ký thành công');
        Get.back();
      }
      // else {
      //   showTopSnackBarError(context, TransactionConstants.unknownError.tr);
      //   //
      //   // } else {
      //   //   debugPrint('đăng nhập thất bại');
      //   //   errorText.value = TransactionConstants.loginError.tr;
      // }
    }

    rxLoadedButton.value = LoadedType.finish;
  }

  void onChangedEmail() {
    checkButtonEnable();
    emailValidate.value = '';
  }

  void onTapEmailTextField() {
    pwdHasFocus.value = false;
    lastNameHasFocus.value = false;
    firstNameHasFocus.value = false;
    emailHasFocus.value = true;
  }

  void onEditingCompleteEmail() {
    pwdHasFocus.value = true;
    emailHasFocus.value = false;
    FocusScope.of(context).requestFocus(passwordFocusNode);
  }

  void onChangedPwd() {
    checkButtonEnable();
    passwordValidate.value = '';
  }

  void onTapPwdTextField() {
    pwdHasFocus.value = true;
    lastNameHasFocus.value = false;
    firstNameHasFocus.value = false;
    emailHasFocus.value = false;
  }

  void onEditingCompletePwd() {
    pwdHasFocus.value = false;
    firstNameHasFocus.value = true;
    FocusScope.of(context).requestFocus(firstNameFocusNode);
  }

  void onChangedFirstName() {
    checkButtonEnable();
    firstNameValidate.value = '';
  }

  void onTapFirstNameTextField() {
    pwdHasFocus.value = false;
    lastNameHasFocus.value = false;
    firstNameHasFocus.value = true;
    emailHasFocus.value = false;
  }

  void onEditingCompleteFirstName() {
    firstNameHasFocus.value = false;
    lastNameHasFocus.value = true;
    FocusScope.of(context).requestFocus(lastNameFocusNode);
  }

  void onChangedLastName() {
    checkButtonEnable();
    lastNameValidate.value = '';
  }

  void onTapLastNameTextField() {
    pwdHasFocus.value = false;
    lastNameHasFocus.value = true;
    firstNameHasFocus.value = false;
    emailHasFocus.value = false;
  }

  void onEditingCompleteLastName() {
    lastNameHasFocus.value = false;
    FocusScope.of(context).unfocus();
    if (buttonEnable.value) {
      postRegister();
    }
  }

  void onPressedRegister() {
    pwdHasFocus.value = false;
    lastNameHasFocus.value = false;
    firstNameHasFocus.value = false;
    emailHasFocus.value = false;
    if (buttonEnable.value) {
      postRegister();
    }
  }

  onPressLogin() {
    Get.back();
  }

  @override
  void onReady() async {
    super.onReady();
    emailFocusNode.addListener(() {
      emailHasFocus.value = emailFocusNode.hasFocus;
    });
    passwordFocusNode.addListener(() {
      pwdHasFocus.value = passwordFocusNode.hasFocus;
    });
  }
}
