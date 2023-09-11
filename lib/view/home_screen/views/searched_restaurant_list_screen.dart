import 'package:foodguru/app_values/export.dart';

class SearchedRestaurantListScreen
    extends GetView<SearchedRestaurantListController> {
  const SearchedRestaurantListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(result: true,
        titleWidget: searchTextFieldWidget(
          hint: TextFile.searchRestaurant.tr,
          controller: controller.searchController,
          focusNode: controller.searchNode,
          onChanged: (value) {
            controller.searchFunction(value);
          },
        ),
      ),
      body: Obx(() => controller.restaurantList.isEmpty?listEmptyWidget(text: TextFile.noRestaurantsFound.tr,icon: Icons.restaurant):SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _searchedRestaurantList(),
            // _relatedRestaurantsText(),
            // _relatedRestaurantsList(),
          ]),
        ),
      ),
    );
  }

  _searchedRestaurantList() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: margin_15,vertical: margin_10),
      itemCount: controller.restaurantList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var data = controller.restaurantList[index];
        return GetInkwell(
          onTap: () {
            Get.toNamed(AppRoutes.restaurantDetailsScreen,
                arguments: {keyId: data.outletId,keyIndex:index});
          },
          child: RestaurantItemWidget(index: index,
            imageUrl: data.logo,
            restaurantName: data.restaurantName,
            rating: data.averageRating,

            description: data.categoryId,
            freeDeliveryAbove: data.freeDeliveryAbove,
            outlet: data.outlet,

          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: height_10,
        );
      },
    ).marginSymmetric(vertical: margin_5);
  }

  _relatedRestaurantsList() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(margin_15),
      itemCount: controller.restaurantList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var data = controller.restaurantList[index];
        return GetInkwell(
          onTap: () {
            Get.toNamed(AppRoutes.restaurantDetailsScreen,
                arguments: {keyModel: data});
          },
          child: RestaurantItemWidget(
            imageUrl: data.logo,
            restaurantName: data.restaurantName,
            rating: data.averageRating,

            description: data.description,
            freeDeliveryAbove: data.freeDeliveryAbove,
            outlet: data.outlet,

          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: height_10,
        );
      },
    );
  }

  _relatedRestaurantsText() {
    return Text(TextFile.relatedRestaurants.tr,
            style: AppStyle.txtDMSansBold16.copyWith(color: Colors.black))
        .marginSymmetric(horizontal: margin_15);
  }
}
