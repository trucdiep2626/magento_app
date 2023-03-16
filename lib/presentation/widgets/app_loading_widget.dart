import 'package:flutter/material.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/theme/export.dart';

import 'app_image_widget.dart';

class AppLoadingWidget extends StatelessWidget {
  final double? width;

  const AppLoadingWidget({Key? key, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.grey600,
        ),
      ),
    );
  }
}
