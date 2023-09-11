import 'package:foodguru/app_values/export.dart';

class DineInBookTableController extends GetxController {
  Rxn<RestaurantItemDataModel> restaurantModel = Rxn<RestaurantItemDataModel>();
  RxList<TableModel> tableList = <TableModel>[].obs;
  RxList<int> selectedTableIds = <int>[].obs;
  int? outletId;
  Rxn<DateTime> selectedFromDate = Rxn<DateTime>();
  Rxn<TimeOfDay> selectedFromTime = Rxn<TimeOfDay>();
  Rxn<DateTime> selectedToDate = Rxn<DateTime>();
  Rxn<TimeOfDay> selectedToTime = Rxn<TimeOfDay>();
  TextEditingController? selectDateController;
  TextEditingController? selectFromTimeController;
  TextEditingController? selectToTimeController;
  int? numberOfPersons = 0;

  @override
  void onInit() {
    initializeFields();
    getArguments();
    super.onInit();
  }

  getArguments() {
    if (Get.arguments != null) {
      outletId = Get.arguments[keyId];
      getRestaurantDetails();
    }
  }

  initializeFields() {
    selectDateController = TextEditingController();
    selectFromTimeController = TextEditingController();
    selectToTimeController = TextEditingController();
  }

  seatSizeImages(seatSize) {
    Map<String, dynamic> data = <String, dynamic>{};
    switch (seatSize) {
      case 2:
        data['unavailable'] = ImageConstant.imagesIcSeat2Unavailable;
        data['available'] = ImageConstant.imagesIcSeat2Available;
        data['selected'] = ImageConstant.imagesIcSeat2Selected;
        return data;
      case 4:
        data['unavailable'] = ImageConstant.imagesIcSeat4Unavailable;
        data['available'] = ImageConstant.imagesIcSeat4Available;
        data['selected'] = ImageConstant.imagesIcSeat4Selected;
        return data;
      case 6:
        data['unavailable'] = ImageConstant.imagesIcSeat6Unavailable;
        data['available'] = ImageConstant.imagesIcSeat6Available;
        data['selected'] = ImageConstant.imagesIcSeat6Selected;
        return data;
      default:
        data['unavailable'] = ImageConstant.imagesIcSeat6Unavailable;
        data['available'] = ImageConstant.imagesIcSeat6Available;
        data['selected'] = ImageConstant.imagesIcSeat6Selected;
        return data;
    }
  }

  getRestaurantDetails() async {
    await OutletNetwork.getRestaurantById(id: outletId).then((value) {
      restaurantModel.value = value!;
    });
  }

  getTableList() async {
    tableList.value = (await DineInTableNetwork.getTableList(
        outletId: outletId,
        fromTime: selectedFromDate.toString(),
        toTime: selectedToDate.toString()))!;
  }

  fromTimePicker() async {
    if (selectedFromDate.value != null) {
      selectedFromTime.value = await showTimePicker(
        context: Get.context!,
        initialTime: DateFormat('yyyy-MM-dd').format(selectedFromDate.value!) ==
                DateFormat('yyyy-MM-dd').format(DateTime.now())
            ? TimeOfDay.now()
            : TimeOfDay(hour: 00, minute: 00),
      );
      if (selectedFromTime.value != null) {
        DateTime updatedDateTime = DateTime(
          selectedFromDate.value!.year,
          selectedFromDate.value!.month,
          selectedFromDate.value!.day,
          selectedFromTime.value!.hour,
          selectedFromTime.value!.minute,
        );
        if (updatedDateTime.isBefore(DateTime.now())) {
          showToast(TextFile.enterValidTime.tr, isDarkMode: true);
        } else {
          selectedFromDate.value = updatedDateTime;
          selectFromTimeController?.text =
              DateFormat('hh:mm k').format(selectedFromDate.value!);
          selectedToTime.value=null;
          selectToTimeController?.text='';
          tableList.value=[];

        }
      }
    } else {
      showToast(TextFile.pleaseSelectDateFirst.tr, isDarkMode: true);
    }
  }

  toTimePicker() async {
    if (selectedFromTime.value != null) {
      selectedToTime.value = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay(
            hour: selectedFromDate.value!.hour,
            minute: selectedFromDate.value!.minute),
      );
      if (selectedToTime.value != null) {
        DateTime updatedDateTime = DateTime(
          selectedToDate.value!.year,
          selectedToDate.value!.month,
          selectedToDate.value!.day,
          selectedToTime.value!.hour,
          selectedToTime.value!.minute,
        );
        if (updatedDateTime.isBefore(selectedFromDate.value!)) {
          showToast(TextFile.enterValidTime.tr, isDarkMode: true);
        } else {
          selectedToDate.value = updatedDateTime;
          selectToTimeController?.text =
              DateFormat('hh:mm k').format(selectedToDate.value!);
          debugPrint(selectedToDate.value.toString());
          getTableList();
        }
      }
    } else {
      showToast(TextFile.pleaseSelectFromTimeFirst.tr);
    }
  }

  navigateToMenuScreen() async {
    UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
    OrderDataSendModel orderDataSendModel = OrderDataSendModel(
      userId: userDbModel.id,
      orderType: keyOrderTypeDineIn,
      numberOfPersons: numberOfPersons,
      stateId: keyOrderPlaced,
      outletId: restaurantModel.value?.outletId,
      tableId: selectedTableIds.join(','),
      fromTime: selectedFromDate.toString(),
      toTime: selectedToDate.toString(),
    );
    Get.toNamed(AppRoutes.menuScreen,
        arguments: {keyModel: orderDataSendModel});
    // debugPrint(orderDataSendModel.toJson().toString());
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
