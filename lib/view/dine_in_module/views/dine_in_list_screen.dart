import 'package:flutter_animate/flutter_animate.dart';
import 'package:foodguru/app_values/export.dart';

class DineInListScreen extends StatelessWidget {
  const DineInListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DineInListController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: ColorConstant.black900,
          appBar: CustomAppBar(
            actions: [
              GetInkwell(
                onTap: () {
                  controller.isMapView = !controller.isMapView;
                  controller.update();
                  debugPrint(controller.isMapView.toString());
                },
                child: Icon(
                  Icons.map_rounded,
                  color: controller.isMapView == true
                      ? ColorConstant.greenA700
                      : ColorConstant.gray600,
                ).marginOnly(right: margin_15),
              )
            ],
            titleColor: Colors.white,
            iosStatusBarBrightness: Brightness.dark,
            title: TextFile.dineIn.tr,
          ),
          body: controller.isMapView == true
              ? _itemsMapView(controller)
              : _itemsListView(controller),
        );
      },
    );
  }

  _itemsListView(DineInListController controller) {
    return Column(
      children: [
        searchTextFieldWidget(
                controller: controller.searchController,
                focusNode: controller.searchNode,
                rightPadding: 0,
                onChanged: (value) {
                  controller.searchFunction(value);
                },
                hint: TextFile.searchRestaurant.tr)
            .marginSymmetric(horizontal: margin_15),
        Expanded(
          child: SingleChildScrollView(
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.dineInList.length,
              padding: EdgeInsets.symmetric(
                  vertical: margin_5, horizontal: margin_15),
              itemBuilder: (context, index) {
                var data = controller.dineInList[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.dineInDetailsScreen,
                        arguments: {keyId: data.outletId, keyIndex: index});
                  },
                  child: Stack(
                    clipBehavior: Clip.none,

                    children: [
                      _restaurantImage(data, index),
                      _shadowEffect(data),
                      _restaurantLogo(data, index),
                      _restaurantDetailView(data,index),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: height_70,
                );
              },
            ).marginOnly(bottom: margin_50),
          ).marginOnly(top: margin_10),
        ),
      ],
    );
  }

  _restaurantImage(RestaurantItemDataModel data, int index) {
    return AssetImageWidget(
      data.images?.first.imageUrl,
      height: height_150,
      width: Get.width,
      boxFit: BoxFit.cover,
      radiusAll: radius_10,
    );
  }

  _shadowEffect(RestaurantItemDataModel data) {
    return Container(
      height: height_150,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius_10),
          gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.7), Colors.transparent],
              begin: Alignment.topLeft,
              stops: [0.1, 0.4],
              end: Alignment.bottomRight)),
    );
  }

  _restaurantLogo(RestaurantItemDataModel data, int index) {
    return Hero(
      tag: '$heroRestaurantLogo$index',
      child: AssetImageWidget(
        data.logo,
        height: height_40,
        width: height_40,
        radiusAll: radius_50,
      ).marginOnly(top: margin_10, left: margin_10, bottom: margin_10),
    );
  }

  _restaurantDetailView(RestaurantItemDataModel data, int index) {
    return Positioned(
      bottom: -margin_45,
      left: 0,
      right: 0,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: margin_15),
        padding:
            EdgeInsets.symmetric(vertical: margin_5, horizontal: margin_10),
        width: Get.width,
        decoration: BoxDecoration(
          color: ColorConstant.blueGray90001,
          borderRadius: BorderRadius.circular(radius_5),
          boxShadow: [
            BoxShadow(
              color: ColorConstant.black90019,
              blurRadius: 6,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    data.restaurantName ?? '',
                    style: AppStyle.txtDMSansBold16WhiteA700,
                  ),
                ),
                Text(
                  data.averageRating?.toStringAsFixed(1) ?? '',
                  style: AppStyle.txtInterMedium12
                      .copyWith(color: ColorConstant.whiteA700),
                ),
                Icon(Icons.star_rounded,
                    color: ColorConstant.yellowFF9B26, size: height_15),
              ],
            ),
            Text(
              data.categoryId ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.txtDMSansRegular12WhiteA700,
            ).marginSymmetric(vertical: margin_2),
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Text.rich(TextSpan(
                      text: '${TextFile.outlet.tr} - ',
                      style: AppStyle.txtDMSansMedium12WhiteA700,
                      children: [
                        TextSpan(
                            text: data.outlet,
                            style: AppStyle.txtDMSansRegular12WhiteA700)
                      ])),
                ),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Text(
                        convertDistance(2500),
                        style: AppStyle.txtInterMedium12WhiteA700,
                      ).marginOnly(left: margin_5),
                      VerticalDivider(
                        color: ColorConstant.gray200,
                      ),
                      Text(
                        '10 ${TextFile.mins.tr}',
                        maxLines: 1,
                        style: AppStyle.txtInterMedium12WhiteA700,
                      )
                    ],
                  ),
                )
              ],
            ),
            Divider(
              color: ColorConstant.gray800,
            ),
            Align(
              alignment: Alignment.center,
              child: Text('Buy 1 get 1 offer on order above 499',
                  style: AppStyle.txtDMSansMedium12WhiteA700),
            ),
          ],
        ),
      ),
    );
  }

  _selectedRestaurantView(DineInListController controller) {
    return GetInkwell(
      onTap: () {
        Get.toNamed(AppRoutes.dineInDetailsScreen,
            arguments: {keyId: controller.selectedRestaurant.value?.id});
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: margin_15),
        padding:
            EdgeInsets.symmetric(vertical: margin_10, horizontal: margin_10),
        width: Get.width,
        decoration: BoxDecoration(
          color: ColorConstant.blueGray90001,
          borderRadius: BorderRadius.circular(radius_12),
          boxShadow: [
            BoxShadow(
              color: ColorConstant.black90019,
              blurRadius: 6,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AssetImageWidget(
                  controller.selectedRestaurant.value?.logo,
                  height: height_40,
                  width: height_40,
                  radiusAll: radius_50,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.selectedRestaurant.value?.restaurantName ??
                            '',
                        style: AppStyle.txtDMSansBold16WhiteA700,
                      ),
                      Text(
                        controller.selectedRestaurant.value?.description ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.txtDMSansRegular12WhiteA700,
                      ).marginSymmetric(vertical: margin_2),
                      Text.rich(TextSpan(
                          text: '${TextFile.outlet.tr} - ',
                          style: AppStyle.txtDMSansMedium12WhiteA700,
                          children: [
                            TextSpan(
                                text:
                                    controller.selectedRestaurant.value?.outlet,
                                style: AppStyle.txtDMSansRegular12WhiteA700)
                          ])),
                    ],
                  ).marginOnly(left: margin_10),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(
                          controller.selectedRestaurant.value?.averageRating?.toStringAsFixed(1) ?? '',
                          style: AppStyle.txtInterMedium12
                              .copyWith(color: ColorConstant.whiteA700),
                        ),
                        Icon(Icons.star_rounded,
                            color: ColorConstant.yellowFF9B26, size: height_15),
                      ],
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Text(
                            convertDistance(500),
                            style: AppStyle.txtInterMedium12WhiteA700,
                          ).marginOnly(left: margin_5),
                          VerticalDivider(
                            color: ColorConstant.gray200,
                          ),
                          Text(
                            '5 ${TextFile.mins.tr}',
                            maxLines: 1,
                            style: AppStyle.txtInterMedium12WhiteA700,
                          )
                        ],
                      ).marginOnly(top: margin_15),
                    )
                  ],
                ),
              ],
            ),
            Divider(
              color: ColorConstant.gray800,
            ),
            Align(
              alignment: Alignment.center,
              child: Text('Buy 1 get 1 offer on order above 499',
                  style: AppStyle.txtDMSansMedium12WhiteA700),
            ),
          ],
        ),
      ).animate().fade().marginOnly(bottom: margin_30),
    );
  }

  _googleMapView(DineInListController controller) {
    return GoogleMap(
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      mapType: MapType.normal,
      markers: controller.markers,
      buildingsEnabled: true,
      onCameraMove: (position) {
        controller.cameraPosition = position;
      },
      initialCameraPosition: controller.cameraPosition ??
          CameraPosition(target: LatLng(28.644800, 77.216721), zoom: 15.5),
      onMapCreated: (cntrller) async {
        if (controller.googleMapsController.isCompleted == false) {
          controller.googleMapsController.complete(cntrller);
        }

        GoogleMapController mapController =
            await controller.googleMapsController.future;
        controller.changeMapMode(mapController);
        controller.setMarkers();
      },
    );
  }

  _itemsMapView(DineInListController controller) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        _googleMapView(controller),
        controller.selectedRestaurant.value != null
            ? _selectedRestaurantView(controller)
            : Container(),
      ],
    );
  }
}
