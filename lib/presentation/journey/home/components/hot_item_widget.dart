import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/domain/models/product_model.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class HotItemWidget extends StatelessWidget {
  const HotItemWidget({Key? key, required this.productModel}) : super(key: key);

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      margin: EdgeInsets.symmetric(horizontal: 16.sp),
      width: Get.width / 2,
      padding: EdgeInsets.all(16.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppImageWidget(
            url:
                '${NetworkConfig.baseMediaUrl}${productModel.mediaGalleryEntries?.first.file ?? ''}',
          ),
          const SizedBox(height: 16),
          Text(
            productModel.name ?? '',
            style: ThemeText.bodySemibold,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text('${productModel.price ?? 0}', style: ThemeText.bodySemibold),
          const Spacer(),
          _buildAddToCartButton(),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return AppTouchable(
      onPressed: () {},
      padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 16.sp),
      backgroundColor: AppColors.black,
      child: Text(
        TransactionConstants.addToCartButton.tr,
        style: ThemeText.bodySemibold.colorWhite,
      ),
    );
  }
}
