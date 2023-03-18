import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';

class RegisterController extends GetxController with MixinController {
  // Rx<ButtonState> buttonState = ButtonState.active.obs;
  //
  // final AuthenticationUseCase authUseCase;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  RxString errorText = ''.obs;

  RxString emailValidate = ''.obs;
  RxString passwordValidate = ''.obs;
  RxString confirmPasswordValidate = ''.obs;

  RxBool confirmPwdHasFocus = false.obs;
  RxBool emailHasFocus = false.obs;
  RxBool pwdHasFocus = false.obs;

  RxBool buttonEnable = false.obs;

  // RegisterController({required this.authUseCase});

  void checkButtonEnable() {
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      buttonEnable.value = true;
    } else {
      buttonEnable.value = false;
    }
  }

  void postRegister() async {}

  void onChangedEmail() {
    checkButtonEnable();
    emailValidate.value = '';
  }

  void onTapEmailTextField() {
    pwdHasFocus.value = false;
    confirmPwdHasFocus.value = false;
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
    confirmPwdHasFocus.value = false;
    emailHasFocus.value = false;
  }

  void onEditingCompletePwd() {
    pwdHasFocus.value = false;
    confirmPwdHasFocus.value = true;
    FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
  }

  void onChangedConfirmPwd() {
    checkButtonEnable();
    confirmPasswordValidate.value = '';
  }

  void onTapConfirmPwdTextField() {
    pwdHasFocus.value = false;
    confirmPwdHasFocus.value = true;
    emailHasFocus.value = false;
  }

  void onEditingCompleteConfirmPwd() {
    confirmPwdHasFocus.value = false;
    FocusScope.of(context).unfocus();
    if (buttonEnable.value) {
      postRegister();
    }
  }

  void onPressedRegister() {
    pwdHasFocus.value = false;
    confirmPwdHasFocus.value = false;
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
    confirmPasswordFocusNode.addListener(() {
      confirmPwdHasFocus.value = confirmPasswordFocusNode.hasFocus;
    });
  }
}
