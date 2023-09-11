import 'package:foodguru/app_values/export.dart';

class ItemListScreen extends GetView<ItemListController> {
  ItemListScreen({Key? key}) : super(key: key);

  var dsh = Get.isRegistered<ItemListController>()
      ? Get.find<ItemListController>()
      : Get.put(ItemListController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: CustomAppBar(
          title: controller.category.value,
          result: true,
          titleWidget: Text(controller.category.value,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: AppStyle.txtDMSansBold24Black900
                  .copyWith(color: ColorConstant.black900)),
          actions: [
            GetInkwell(
                onTap: () {
                  Get.toNamed(AppRoutes.searchScreen);
                },
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: height_25,
                ).marginOnly(right: margin_15))
          ],
        ),
        body: ListView.separated(
          shrinkWrap: true,
          itemCount: controller.itemsList.length,
          padding: EdgeInsets.all(margin_15),
          itemBuilder: (context, index) {
            var data = controller.itemsList[index];
            return Obx(
              () => GetInkwell(
                onTap: () async {
                  var result = await Get.toNamed(AppRoutes.itemDetailsScreen,
                      arguments: {keyId: data.itemId});
                  if (result != null) {
                    controller.fetchData();
                  }
                },
                child: MenuItemView(
                  imageUrl: data.images?.first.imageUrl,
                  dishName: data.itemName,
                  description: data.description,
                  itemModel: data,
                  onAddToCartPress: (value) {
                    data.isAddedToCart?.value = value;
                    // controller.itemsList.refresh();
                    controller.fetchData();
                    controller.update();
                  },
                  onFavouritePress: (int value) {
                    controller.itemsList.refresh();
                  },
                  onAddTap: () {
                    controller.itemsList.refresh();
                    controller.update();
                  },
                  onRemoveTap: () {
                    controller.itemsList.refresh();
                  },
                  onItemRemovedFromCart: () {
                    data.quantity?.value = 0;
                    controller.update();
                  },
                  discountedPrice: data.discountedPrice.toString(),
                  distance: 40,
                  itemPrice: data.itemPrice.toString(),
                  isVeg: data.isVeg,
                  isAddedToCart: data.isAddedToCart?.value,
                  pointsPerQuantity: data.pointsPerQuantity.toString(),
                  restaurantName: data.restaurantName,
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: height_10);
          },
        ),
      ),
    );
  }
}
