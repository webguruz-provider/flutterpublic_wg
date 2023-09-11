import 'package:foodguru/app_values/export.dart';

class DineInBookingDetailsController extends GetxController {
  Rxn<DateTime> selectedFromDate = Rxn<DateTime>();
  Rxn<TimeOfDay> selectedFromTime = Rxn<TimeOfDay>();
  Rxn<DateTime> selectedToDate = Rxn<DateTime>();
  Rxn<TimeOfDay> selectedToTime = Rxn<TimeOfDay>();

  TextEditingController? selectDateController;
  TextEditingController? selectFromTimeController;
  TextEditingController? selectToTimeController;
  Rxn<OrderDataSendModel> orderDataSendModel = Rxn<OrderDataSendModel>();
  RxList<ItemModel> itemsList = <ItemModel>[].obs;

  @override
  void onInit() {
    initializeFields();
    getArguments();
    super.onInit();
  }

  getArguments() {
    if (Get.arguments != null) {
      itemsList.value=Get.arguments[keyList];
      orderDataSendModel.value=Get.arguments[keyModel];
      orderDataSendModel.value?.grandTotal=itemsList.fold(0, (previousValue, element) => previousValue!+int.parse(element.discountedPrice ?? '1'));
    }
  }

  initializeFields() {
    selectDateController = TextEditingController();
    selectFromTimeController = TextEditingController();
    selectToTimeController = TextEditingController();
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
              DateFormat('hh:mm').format(selectedFromDate.value!);
          debugPrint(selectedFromDate.value.toString());
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
              DateFormat('hh:mm').format(selectedToDate.value!);
          debugPrint(selectedToDate.value.toString());
        }
      }
    } else {
      showToast(TextFile.pleaseSelectFromTimeFirst.tr);
    }
  }

  addDineinBooking() async {

    await OrderNetwork.addDineInOrder(data: orderDataSendModel.toJson(), itemList:itemsList.value,onSuccess: () {
      Get.offAllNamed(AppRoutes.orderSuccessScreen,
          arguments: {fromDineInKey: true});
    },);
  }

}
