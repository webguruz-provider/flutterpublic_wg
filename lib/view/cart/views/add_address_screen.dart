import 'package:foodguru/app_values/export.dart';

class AddAddressScreen extends GetView<AddAddressController> {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(backgroundColor: ColorConstant.gray50,title: TextFile.addNewAddress.tr),
        body: Obx(
      () => Stack(
        alignment: Alignment.center,
        children: [
          _googleMapView(),
          _markerView(),
          _addressView(),
        ],
      ),
    ));
  }




  _googleMapView() {
    return GoogleMap(
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      mapType: MapType.normal,
      buildingsEnabled: true,
      onCameraMove: (position) {
        controller.cameraPosition = position;
      },
      onCameraMoveStarted: () {
        if (controller.isMannualAddress.value == false) {
          controller.address.value = null;
        }
        debugPrint('Start');
      },
      onCameraIdle: () {
        debugPrint('Stop');

          controller
              .getAddress(controller.cameraPosition?.target.latitude ?? 0.0,
                  controller.cameraPosition?.target.longitude ?? 0.0)
              .then((value) {
            controller.address.value = value;
          }).onError((error, stackTrace) {});

      },
      initialCameraPosition: controller.cameraPosition ??
          CameraPosition(target: LatLng(28.644800, 77.216721), zoom: 15.5),
      markers: controller.marker,
      onMapCreated: (cntrller) {
        controller.googleMapsController.complete(cntrller);
      },
    ).marginOnly(bottom: margin_140);
  }

  _markerView() {
    return AssetImageWidget(
      ImageConstant.imagesIcMarker,
      width: width_20,
    ).marginOnly(
        bottom:
            margin_165); //Its Padding should be MapPadding+25 for perfect Alignment
  }

  _addressView() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(margin_15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius_20),
                topRight: Radius.circular(radius_20))),
        child: controller.address.value != null
            ? _loadedAddressView()
            : _shimmerAddressView(),
      ),
    );
  }

  _loadedAddressView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        controller.isMannualAddress.value == true
            ? _addressTextField()
            : _addressText(),
        _setMannualButton(),
        _confirmLocationButton(),
      ],
    );
  }

  _shimmerAddressView() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: width_25,
                height: width_25,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(radius_20)),
              ),
              Expanded(
                  child: Container(
                height: height_25,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(radius_20)),
              ).marginOnly(left: margin_10)),
            ],
          ),
          Container(
            height: height_15,
            width: width_60,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(radius_20)),
          ).marginOnly(top: margin_10, left: margin_30),
          CustomButton(
            height: 45,
            width: getSize(width),
            shape: ButtonShape.RoundedBorder22,
            text: TextFile.confirmLocation.tr,
            margin: getMargin(top: margin_15),
            variant: ButtonVariant.OutlineBlack9003f,
            fontStyle: ButtonFontStyle.InterSemiBold18,
            onTap: () {},
          ).marginOnly(bottom: margin_10),
        ],
      ),
    );
  }

  _addressTextField() {
    return CustomTextFormField(
      focusNode: controller.addressNode,
      controller: controller.addressTextController,
      onChanged: (value) {

      },
      maxLength: 50,
      contentPadding: EdgeInsets.all(margin_15),
      hintText: TextFile.enterCompleteAddress.tr,
      border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstant.gray400, width: width_1),
          borderRadius: BorderRadius.circular(radius_25)),
    );
  }

  _addressText() {
    return Row(
      children: [
        AssetImageWidget(
          ImageConstant.imagesIcMarker,
          width: width_25,
          height: width_25,
        ),
        Expanded(
          child: Text(
            controller.address.value ?? '',
            maxLines: 2,
            style: AppStyle.txtInterRegular16
                .copyWith(color: ColorConstant.black900),
          ).marginOnly(left: margin_10),
        ),
      ],
    );
  }

  _setMannualButton() {
    return Row(
      children: [
        Expanded(
          child: GetInkwell(
            onTap: () {
              controller.isMannualAddress.value = !controller.isMannualAddress.value;
            },
            child: Text(
              !controller.isMannualAddress.value? TextFile.setManually.tr:TextFile.setAutomatic.tr,
              style: AppStyle.txtInterRegular16GreenA700,
            ),
          ),
        ),
        _addressTypeSelection(title: TextFile.home.tr, index: typeHome),
        _addressTypeSelection(title: TextFile.office.tr, index: typeOffice)
            .marginOnly(left: margin_10),
      ],
    ).marginOnly(top: margin_10, left: margin_30);
  }

  _confirmLocationButton() {
    return CustomButton(
            height: 45,
            width: getSize(width),
            shape: ButtonShape.RoundedBorder22,
            text: TextFile.confirmLocation.tr,
            margin: getMargin(top: margin_15),
            variant: ButtonVariant.OutlineBlack9003f,
            fontStyle: ButtonFontStyle.InterSemiBold18,
            onTap: () {
              controller.validationAndAddAddress();
              // controller.addAddressToFirebase();
            })
        .marginOnly(bottom: margin_10);
  }

  Widget _addressTypeSelection({String? title, int? index}) {
    return GetInkwell(
      onTap: () {
        controller.selectedAddressType.value = index;
      },
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: margin_2, horizontal: margin_15),
        decoration: BoxDecoration(
            border: Border.all(
                color: controller.selectedAddressType.value == index
                    ? ColorConstant.greenA700
                    : ColorConstant.gray500),
            color: controller.selectedAddressType.value == index
                ? ColorConstant.greenA700
                : Colors.white,
            borderRadius: BorderRadius.circular(radius_15)),
        child: Text(
          title ?? '',
          style: AppStyle.txtInterRegular16GreenA700.copyWith(
              color: controller.selectedAddressType.value == index
                  ? Colors.white
                  : ColorConstant.gray500),
        ),
      ),
    );
  }
}
