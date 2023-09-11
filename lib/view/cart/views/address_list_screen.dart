import 'package:foodguru/app_values/export.dart';

class AddressListScreen extends GetView<AddressListController> {
  const AddressListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.gray50,
      appBar: CustomAppBar(title: TextFile.deliveryAddress),
      body: Obx(
        () => Column(
          children: [
            _addressListTextAndAddAddressButton(),
            _addressList(),
          ],
        ).marginSymmetric(vertical: margin_15),
      ),
    );
  }

  _addressListTextAndAddAddressButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _addressListText(),
        _addNewAddressButton(),
      ],
    ).marginSymmetric(horizontal: margin_15);
  }

  _addNewAddressButton() {
    return GetInkwell(
      onTap: () async {
        var result = await Get.toNamed(AppRoutes.addAddressScreen);
        if (result != null) {
          controller.getAddressList();
        }
      },
      child: Text(
        '+ ${TextFile.addNewAddress.tr}',
        style: AppStyle.txtDMSansRegular12GreenA700
            .copyWith(decoration: TextDecoration.underline),
      ),
    );
  }

  _addressListText() {
    return Text(
      TextFile.addressList.tr,
      style: AppStyle.txtDMSansRegular14Gray50004,
    );
  }

  _addressList() {
    return Expanded(
        child: controller.addressList.isEmpty
            ? listEmptyWidget(text: TextFile.noAddressFound.tr)
            : ListView.separated(
                itemCount: controller.addressList.length,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                    horizontal: margin_15, vertical: margin_5),
                itemBuilder: (context, index) {
                  return Obx(
                    () => Container(
                      padding: EdgeInsets.all(margin_5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radius_50),
                        boxShadow: [
                          BoxShadow(
                            color: ColorConstant.gray300,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: GetInkwell(
                        onTap: () {
                          controller.selectedAddress.value = index;

                          if(controller.fromHomeView == true){
                            var  currentAddress = controller.addressList[index].address;
                            PreferenceManger().selectedLocation(currentAddress);
                          }

                          if (controller.fromProfileView == false) {
                            Get.back(result: controller.addressList[index]);
                          }

                        },
                        child: Row(children: [
                          _addressTypeImage(index),
                          _addressAndDeleteButton(index),
                          _selectedUnselectedIcon(index),
                        ]),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: height_10,
                  );
                },
              ).marginOnly(top: margin_10));
  }

  _addressTypeImage(int index) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius_50),
            boxShadow: [
              BoxShadow(
                color: ColorConstant.black9000f,
                blurRadius: 2,
              )
            ]),
        child: AssetImageWidget(
          controller.addressList[index].addressType == typeHome
              ? ImageConstant.imagesIcHome
              : ImageConstant.imagesIcOffice,
          radiusAll: radius_50,
          width: width_50,
        ));
  }

  _addressTextView(int index) {
    return Text(controller.addressList[index].address ?? '',
        style: AppStyle.txtInterRegular14Black900);
  }

  _deleteAddressButton(int index) {
    return Row(
      children: [
        GetInkwell(
          onTap: () {
            Get.dialog(
              _deleteAddressDialog(index),
            );
          },
          child: Text(TextFile.delete.tr,
              style: AppStyle.txtInterRegular12.copyWith(
                  color: Colors.red, decoration: TextDecoration.underline)),
        ),
        GetInkwell(
          onTap: () async {
            var result = await Get.toNamed(AppRoutes.addAddressScreen,
                arguments: {keyModel: controller.addressList[index]});
            if (result != null) {
              controller.getAddressList();
            }
          },
          child: Text(TextFile.edit.tr,
              style: AppStyle.txtInterRegular12.copyWith(
                  color: ColorConstant.greenA700,
                  decoration: TextDecoration.underline)),
        ).marginOnly(left: margin_10),
      ],
    );
  }

  _addressAndDeleteButton(int index) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _addressTextView(index),
          _deleteAddressButton(index),
        ],
      ).marginOnly(left: margin_5),
    );
  }

  _selectedUnselectedIcon(int index) {
    return AssetImageWidget(
      controller.selectedAddress.value == index
          ? ImageConstant.imagesIcSelectedAddress
          : ImageConstant.imagesIcUnselectedAddress,
      width: width_30,
    ).marginOnly(right: margin_5);
  }

  Widget _deleteAddressDialog(int index) {
    return Center(
      child: Container(
          padding: EdgeInsets.all(margin_15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius_12)),
          child: Material(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      TextFile.addressDeleteWarning.tr,
                      textAlign: TextAlign.center,
                      style: AppStyle.txtDMSansBold16
                          .copyWith(color: Colors.black),
                    ),
                    Text(
                      controller.addressList[index].address ?? '',
                      textAlign: TextAlign.center,
                      style: AppStyle.txtDMSansRegular14Black900,
                    ).marginOnly(top: margin_15),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                              height: 45,
                              width: getSize(width),
                              shape: ButtonShape.RoundedBorder22,
                              text: TextFile.no.tr,
                              margin: getMargin(top: margin_20),
                              variant: ButtonVariant.OutlineBlack9003f_1,
                              fontStyle: ButtonFontStyle.InterSemiBold18,
                              onTap: () {
                                Get.back();
                              }),
                        ),
                        SizedBox(
                          width: width_15,
                        ),
                        Expanded(
                          child: CustomButton(
                              height: 45,
                              width: getSize(width),
                              shape: ButtonShape.RoundedBorder22,
                              text: TextFile.yes.tr,
                              margin: getMargin(top: margin_20),
                              variant: ButtonVariant.OutlineBlack9003f,
                              fontStyle: ButtonFontStyle.InterSemiBold18,
                              onTap: () async {
                                Get.back();
                                await AddressNetwork.deleteAddress(
                                  controller.addressList[index].id,
                                  onSuccess: () {
                                    controller.addressList.removeAt(index);
                                  },
                                );
                              }),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          )),
    ).marginAll(margin_15);
  }
}
