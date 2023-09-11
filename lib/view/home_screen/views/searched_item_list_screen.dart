import 'package:foodguru/app_values/export.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

class SearchedItemListScreen extends GetView<SearchedItemListController> {
  const SearchedItemListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(result: true,
        titleWidget: searchTextFieldWidget(
            focusNode: controller.searchNode,
            controller: controller.searchController,
            onChanged: (value) {
              Debouncer debouncer = Debouncer(
                delay: Duration(seconds: 3),
              );
              debouncer.call(
                () {
                  controller.searchedValue.value =
                      controller.searchController?.text ?? '';
                },
              );
              controller.searchedValue.value = value;
            },
            hint: TextFile.searchFood.tr),
      ),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${TextFile.showingResutsFor.tr} ${controller.searchedValue.value}',
                    style: AppStyle.txtDMSansBold16Black90001
                        .copyWith(color: Colors.black))
                .marginOnly(bottom: margin_10),
            Expanded(
              child: ListView.separated(
                itemCount: controller.itemsList.length,
                padding: EdgeInsets.symmetric(vertical: margin_5),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var data = controller.itemsList[index];
                  return GetInkwell(
                    onTap: () {
                      Get.toNamed(AppRoutes.itemDetailsScreen,
                          arguments: {keyId: data.itemId});
                    },
                    child: Obx(
                      () => MenuItemView(
                        imageUrl: data.images?.first.imageUrl ??
                            ImageConstant.imagesIcDosa,
                        dishName: data.itemName,
                        description: data.description,
                        itemModel:  data,

                        onAddToCartPress: (value) {
                          data.isAddedToCart?.value =value;
                          // controller.itemsList.refresh();
                          controller.getItemDetails();
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
                          data.quantity?.value=0;
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
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: height_10,
                  );
                },
              ),
            )
          ],
        ).marginAll(margin_15),
      ),
    );
  }
}
