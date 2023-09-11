
import 'package:flutter_animate/flutter_animate.dart';
import 'package:foodguru/app_values/export.dart';

class DineInBookTableScreen extends GetView<DineInBookTableController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: ColorConstant.black900,
        appBar: CustomAppBar(
          iosStatusBarBrightness: Brightness.dark,
          title: controller.restaurantModel.value?.restaurantName ?? '',
          titleColor: ColorConstant.whiteA700,
          iconColor: ColorConstant.whiteA700,
        ),
        floatingActionButton: Obx(() => controller.selectedTableIds.isEmpty
            ? Container()
            : _confirmTableButton()),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _selectDateText(),
              _selectDateTextField(),
              _selectTimeText(),
              _selectTimeTextField(),
              if(controller.tableList.isNotEmpty)...[
                _selectTableSeats(),
                _tableState(),
                _seatsList(),
              ]

            ],
          ),
        ),
      ),
    );
  }

  Widget _tableStateInfo({String? title, Color? color, bool isBorder = false}) {
    return Row(
      children: [
        Container(
            width: width_10,
            height: width_10,
            decoration: BoxDecoration(
                color: color ?? Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isBorder == true ? Colors.white : Colors.transparent,
                ))),
        Text(title ?? '', style: AppStyle.txtDMSansRegular16WhiteA700)
            .marginOnly(left: margin_10)
      ],
    );
  }

  _confirmTableButton() {
    return SafeArea(
      child: CustomButton(
          height: 45,
          width: getSize(width),
          shape: ButtonShape.RoundedBorder22,
          text: TextFile.confirmTable.tr,
          margin: getMargin(
              top: margin_20,
              left: margin_15,
              right: margin_15,
              bottom: margin_20),
          variant: ButtonVariant.OutlineBlack9003f,
          fontStyle: ButtonFontStyle.InterSemiBold18,
          onTap: () {
            controller.navigateToMenuScreen();

          }).animate().fadeIn(curve: Curves.easeIn),
    );
  }

  _seatsList() {
    return Obx(
      () => GridView.builder(shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(
            left: margin_15,
            right: margin_15,
            top: margin_5,
            bottom: margin_70),
        itemCount: controller.tableList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: height_30,
            crossAxisSpacing: height_30),
        itemBuilder: (context, index) {
          return Obx(
            () => GetInkwell(
              onTap: () {
                if (controller.tableList[index].matchCount == 0) {
                  controller.tableList[index].isSelected?.value =
                      !controller.tableList[index].isSelected!.value;
                  if (controller.tableList[index].isSelected?.value ==
                      true) {
                    controller.selectedTableIds
                        .add(controller.tableList[index].id!);
                    controller.numberOfPersons=controller.numberOfPersons!+int.parse(controller.tableList[index].seatSize.toString());
                    debugPrint(controller.numberOfPersons.toString());
                  } else {
                    controller.selectedTableIds
                        .remove(controller.tableList[index].id!);
                    controller.numberOfPersons=controller.numberOfPersons!-int.parse(controller.tableList[index].seatSize.toString());
                    debugPrint(controller.numberOfPersons.toString());
                  }
                  debugPrint(controller.selectedTableIds.toString());
                }
              },
              child: AssetImageWidget(
                controller.tableList[index].isSelected?.value == true
                    ? controller.seatSizeImages(
                        controller.tableList[index].seatSize)['selected']
                    : controller.tableList[index].matchCount == 0
                        ? controller.seatSizeImages(controller
                            .tableList[index].seatSize)['available']
                        : controller.seatSizeImages(controller
                            .tableList[index].seatSize)['unavailable'],
                height: height_60,
              ),
            ),
          );
        },
      ).marginOnly(top: margin_10),
    );
  }

  _selectTableSeats() {
    return Text(
      TextFile.selectTableSeats.tr,
      style: AppStyle.txtDMSansBold18WhiteA700,
    ).marginOnly(top: margin_15, left: margin_15, right: margin_15);
  }

  _tableState() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _tableStateInfo(
          isBorder: true,
          color: Colors.transparent,
          title: TextFile.available.tr,
        ),
        _tableStateInfo(
          color: ColorConstant.greenA700,
          title: TextFile.selected.tr,
        ),
        _tableStateInfo(
          color: ColorConstant.gray500,
          title: TextFile.reserved.tr,
        ),
      ],
    ).marginOnly(top: margin_10, left: margin_15, right: margin_15);
  }

  _selectDateText() {
    return Text(TextFile.selectDate.tr,
        style: AppStyle.txtDMSansBold18WhiteA700)
        .marginOnly(top: margin_15,left: margin_15,right: margin_15);
  }

  _selectTimeText() {
    return Text(TextFile.selectTime.tr,
        style: AppStyle.txtDMSansBold18WhiteA700)
        .marginOnly(top: margin_20,left: margin_15,right: margin_15);
  }

  _selectDateTextField() {
    return CommonTextFieldWidget(
      inputController: controller.selectDateController,
      border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstant.greenA700),
          borderRadius: BorderRadius.circular(radius_25)),
      hintText: TextFile.selectDate.tr,
      fillColor: Colors.transparent,
      readOnly: true,
      iconPath: ImageConstant.imagesIcCalendar1,
      onTap: () async {
        controller.selectedFromDate.value = await showDatePicker(
            builder: (context, child) {
              return Theme(
                  data: ThemeData.light().copyWith(
                      colorScheme:
                      ColorScheme.light(primary: ColorConstant.greenA700),
                      buttonTheme:
                      ButtonThemeData(textTheme: ButtonTextTheme.primary)),
                  child: child!);
            },
            context: Get.context!,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100));
        if (controller.selectedFromDate.value != null) {
          controller.selectedToDate.value = controller.selectedFromDate.value;
          controller.selectDateController?.text = dateFormatDateTime(
              format: 'dd-MMMM-yyyy', value: controller.selectedFromDate.value);
          debugPrint(controller.selectedFromDate.value.toString());
          controller.selectedFromTime.value=null;
          controller.selectedToTime.value=null;
          controller.selectFromTimeController?.text='';
          controller.selectToTimeController?.text='';
          controller.tableList.value=[];
        }
      },
      onFieldSubmitted: (val) {},
      width: widthSizetextField,
      keyBoardInputType: TextInputType.emailAddress,
    ).marginOnly(top: margin_20,left: margin_15,right: margin_15);
  }

  _selectTimeTextField() {
    return Row(
      children: [
        Expanded(
          child: CommonTextFieldWidget(
            border: OutlineInputBorder(
                borderSide: BorderSide(color: ColorConstant.greenA700),
                borderRadius: BorderRadius.circular(radius_25)),
            hintText: TextFile.from.tr,
            inputController: controller.selectFromTimeController,
            fillColor: Colors.transparent,
            iconPath: ImageConstant.imagesIcClock,
            textInputAction: TextInputAction.next,
            readOnly: true,
            onTap: () {
              controller.fromTimePicker();
            },
            width: widthSizetextField,
            keyBoardInputType: TextInputType.emailAddress,
          ),
        ),
        SizedBox(
          width: width_10,
        ),
        Expanded(
          child: CommonTextFieldWidget(
            readOnly: true,
            inputController: controller.selectToTimeController,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: ColorConstant.greenA700),
                borderRadius: BorderRadius.circular(radius_25)),
            hintText: TextFile.to.tr,
            fillColor: Colors.transparent,
            iconPath: ImageConstant.imagesIcClock,
            textInputAction: TextInputAction.next,
            onTap: () {
              controller.toTimePicker();
            },
            width: widthSizetextField,
            keyBoardInputType: TextInputType.emailAddress,
          ),
        ),
      ],
    ).marginOnly(top: margin_20,left: margin_15,right: margin_15);

  }

}
