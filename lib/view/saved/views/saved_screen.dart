import 'package:foodguru/app_values/export.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedController>(
        init: SavedController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(
                leading: Container(), title: TextFile.savedItems.tr),
            body: controller.itemsList.isEmpty
                ? listEmptyWidget(text: TextFile.noSavedItem.tr)
                : ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(margin_15),
                    itemBuilder: (context, index) {
                      var data = controller.itemsList[index];
                      return GetInkwell(
                        onTap: () async {
                        var result=await  Get.toNamed(AppRoutes.itemDetailsScreen,
                              arguments: {keyId: data.itemId});
                        if(result!=null){
                          controller.getFavouritesList();
                        }
                        },
                        child: MenuItemView(
                          imageUrl: data.images?.first.imageUrl,
                          dishName: data.itemName??'',
                          description: data.description,
                          itemModel:  data,
                          onAddToCartPress: (value) {
                            data.isAddedToCart?.value =value;
                            controller.getFavouritesList();
                            controller.update();
                          },
                          discountedPrice: data.discountedPrice,
                          distance: 40,
                          itemPrice: data.itemPrice,
                          isVeg: data.isVeg,
                          isAddedToCart: data.isAddedToCart?.value,
                          onFavouritePress: (int value) async {
                            data.isFavourite?.value=value;
                            controller.itemsList.removeAt(index);
                            controller.update();
                          },
                          onAddTap: () {

                            controller.update();
                          },
                          onRemoveTap: () {
                            controller.update();
                          },
                          onItemRemovedFromCart: () {
                            data.quantity?.value=0;
                            controller.update();
                          },
                          pointsPerQuantity: data.pointsPerQuantity,
                          
                          restaurantName: data.restaurantName,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: height_10,
                      );
                    },
                    itemCount: controller.itemsList.length),
          );
        });
  }
}
