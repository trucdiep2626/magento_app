import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/journey/home/components/banner_item.dart';
import 'package:magento_app/presentation/journey/home/components/hot_item_widget.dart';
import 'package:magento_app/presentation/journey/home/components/product_type_item.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/app_bar_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:magento_app/presentation/widgets/export.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);

  final List<AssetGenImage> banners = [
    Assets.images.homeBanner1,
    Assets.images.homeBanner2,
    Assets.images.homeBanner3,
  ];

  final productTypeTiles = [
    TransactionConstants.shirt.tr,
    TransactionConstants.pants.tr,
    TransactionConstants.coats.tr,
    TransactionConstants.shoes.tr,
    TransactionConstants.bags.tr,
    TransactionConstants.accessories.tr,
  ];

  final productTypeImages = [
    Assets.images.icPolo,
    Assets.images.icPants,
    Assets.images.icCoat,
    Assets.images.icShoes,
    Assets.images.icBag,
    Assets.images.icNecklace,
  ];

  final bannerImages = [
    '/m/h/mh01-black_main_1.jpg',
    '/w/t/wt04-blue_main_1.jpg',
    '/u/g/ug06-lb-0.jpg',
    '/w/s/ws05-black_back_1.jpg',
  ];

  final bannerTitles = [
    TransactionConstants.men.tr,
    TransactionConstants.women.tr,
    TransactionConstants.gear.tr,
    TransactionConstants.sale.tr,
  ];

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
      backgroundColor: AppColors.grey50,
      appBar: AppBarWidget(
        showMenu: true,
        title: TransactionConstants.mainNavigationHome.tr,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Obx(() => controller.rxLoadedList.value == LoadedType.start
        ? AppLoadingWidget()
        : SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildBannerWidget(),
                const SizedBox(height: 40),
                Text(
                  TransactionConstants.homeLookingfor.tr,
                  style: ThemeText.bodySemibold.s20,
                ),
                const SizedBox(height: 20),
                _buildTypeOfProductList(),
                const SizedBox(height: 40),
                Text(
                  TransactionConstants.hotItems.tr,
                  style: ThemeText.bodySemibold.s20,
                ),
                const SizedBox(height: 20),
                _buildHotItemsList(),
                const SizedBox(height: 40),
                _buildBannersList()
              ],
            ),
          ));
  }

  Widget _buildBannerWidget() {
    return CarouselSlider(
      items: banners
          .map(
            (item) => AppImageWidget(
              asset: item,
              fit: BoxFit.cover,
              width: Get.width,
            ),
          )
          .toList(),
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: false,
        viewportFraction: 1,
        aspectRatio: Get.height / Get.width,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        initialPage: 0,
      ),
    );
  }

  Widget _buildTypeOfProductList() {
    return Wrap(
      children: [
        ProductTypeItem(
          icon: productTypeImages[0],
          title: productTypeTiles[0],
        ),
        ProductTypeItem(
          icon: productTypeImages[1],
          title: productTypeTiles[1],
        ),
        ProductTypeItem(
          icon: productTypeImages[2],
          title: productTypeTiles[2],
        ),
        ProductTypeItem(
          icon: productTypeImages[3],
          title: productTypeTiles[3],
        ),
        ProductTypeItem(
          icon: productTypeImages[4],
          title: productTypeTiles[4],
        ),
        ProductTypeItem(
          icon: productTypeImages[5],
          title: productTypeTiles[5],
        ),
      ],
    );
  }

  _buildHotItemsList() {
    return controller.hotItems.value.length == 0
        ? SizedBox.shrink()
        : SizedBox(
            height: Get.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  HotItemWidget(productModel: controller.hotItems.value[index]),
              itemCount: controller.hotItems.value.length >= 10
                  ? 10
                  : controller.hotItems.value.length,
              shrinkWrap: true,
            ),
          );
  }

  _buildBannersList() {
    return ListView.builder(
      itemBuilder: (context, index) => BannerItem(
        title: bannerTitles[index],
        image: bannerImages[index],
      ),
      itemCount: 4,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }
}
