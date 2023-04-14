import 'package:flutter/material.dart';
import 'package:magento_app/common/utils/export.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class InputMessageWidget extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final Function(String) sendTap;
//  final Function(File) onSendFile;
  const InputMessageWidget({
    Key? key,
    this.hintText,
    this.controller,
    this.onChange,
    required this.sendTap,
    //  required this.onSendFile
  }) : super(key: key);

  @override
  State<InputMessageWidget> createState() => _InputMessageWidgetState();
}

class _InputMessageWidgetState extends State<InputMessageWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.sp,
      margin: EdgeInsets.all(16.sp),
      padding: EdgeInsets.zero,
      // padding:   EdgeInsets.only(top: 10.sp),
      // decoration: BoxDecoration(
      //   boxShadow: [
      //     BoxShadow(
      //       color: AppColors.,
      //       offset: const Offset(0, 4),
      //       blurRadius: 15,
      //     )
      //   ],
      // ),
      child: TextFormField(
        onChanged: (value) {
          if (widget.onChange != null) {
            widget.onChange!(value);
          }
        },
        controller: controller,
        style: ThemeText.bodyRegular,
        decoration: InputDecoration(
          filled: true,
          // hintText: widget.hintText ?? S.current.search_for_contacts,
          hintStyle: ThemeText.bodyRegular.grey200Color,
          fillColor: AppColors.grey200,
          //   contentPadding: EdgeInsets.symmetric(horizontal: 20.sp),
          suffixIcon: AppImageWidget(
            onTap: () {
              if (controller.text.isNotEmpty) {
                widget.sendTap(controller.text);
                controller.text = '';
              }
            },
            asset: Assets.images.icSendSms,
            margin: EdgeInsets.only(top: 4.sp),
          ),

          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
        ),
      ),
    );
  }
}
