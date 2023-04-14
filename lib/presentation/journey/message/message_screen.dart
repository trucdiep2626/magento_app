import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/presentation/journey/message/components/input_message_widget.dart';
import 'package:magento_app/presentation/journey/message/components/message_cell.dart';
import 'package:magento_app/presentation/journey/message/message_controller.dart';
import 'package:magento_app/presentation/widgets/app_bar_widget.dart';

class MessageScreen extends GetView<MessageController> {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // extendBody: true,
      appBar: const AppBarWidget(
        //  showBackButton: true,
        title: 'Support Chat',
        //onPressed: () => Get.back(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(
                20,
                (index) => index % 2 == 0
                    ? const AdminMessageCell()
                    : const CustomerMessageCell(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: Get.mediaQuery.viewPadding.bottom +
              (Get.mediaQuery.viewInsets.bottom == 0 ? Get.width / 10 : 0),
        ),
        child: InputMessageWidget(sendTap: (value) {}),
      ),
    );
  }
}
