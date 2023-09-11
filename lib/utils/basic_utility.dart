import 'package:foodguru/app_values/export.dart';
import 'dart:ui' as ui;

String convertDistance(int meters) {
  if (meters >= 1000) {
    double kilometers = meters / 1000.0;
    return "${kilometers.toStringAsFixed(1)} ${TextFile.km.tr}";
  } else {
    return "$meters ${TextFile.meter.tr}";
  }
}

Widget searchTextFieldWidget(
    {FocusNode? focusNode,
    TextEditingController? controller,
    double? rightPadding,
    Color? borderColor,
    ValueChanged<String>? onChanged,
    Function()? onTap,
    String? hint}) {
  return Hero(tag: 'A',
    child: CustomTextFormField(
      focusNode: focusNode,
      fillColor: Colors.transparent,
      controller: controller,
      onTap: onTap,
      onChanged: onChanged ?? (value) {},
      maxLength: 50,
      prefix: CustomImageView(
        svgPath: ImageConstant.imgSearch,
      ).marginAll(margin_10),
      suffix: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            VerticalDivider(
                color: ColorConstant.gray500,
                thickness: width_1,
                indent: height_8,
                endIndent: height_8),
            CustomImageView(
              svgPath: ImageConstant.imgMenu13x18,
              height: height_12,
            ).marginOnly(right: margin_15, left: margin_4)
          ],
        ),
      ),
      hintText: hint ?? '',
      border: OutlineInputBorder(
          borderSide: BorderSide(
              color: borderColor ?? ColorConstant.gray400, width: width_1),
          borderRadius: BorderRadius.circular(radius_25)),
    ).marginOnly(right: rightPadding ?? margin_15),
  );
}

String addressTextFunction({
  String? houseNo,
  String? street,
  String? city,
  String? state,
  String? zipCode,
}) {
  List<String> addressParts = [];
  if (houseNo != null && houseNo.isNotEmpty) {
    addressParts.add(houseNo);
  }
  if (street != null && street.isNotEmpty) {
    addressParts.add(street);
  }

  if (city != null && city.isNotEmpty) {
    addressParts.add(city);
  }

  if (state != null && state.isNotEmpty) {
    addressParts.add(state);
  }

  if (zipCode != null && zipCode.isNotEmpty) {
    addressParts.add(zipCode);
  }

  return addressParts.join(', ');
}

Widget listEmptyWidget({IconData? icon, String? text, String? image}) {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon != null
            ? Icon(
                icon,
                size: width_40,
              )
            : image != null
                ? AssetImageWidget(image, color: Colors.black, width: width_40)
                : Container(),
        Text(
          text ?? 'No Data Found',
          textAlign: TextAlign.center,
          style: AppStyle.txtDMSansBold18Black900,
        ).marginOnly(top: margin_10),
      ],
    ),
  );
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

subtractYearFromCurrentDate({int? year}) {
  return DateTime(
      DateTime.now().year - year!, DateTime.now().month, DateTime.now().day);
}

dateFormatDateTime({String? format, DateTime? value}) {
  return DateFormat(format ?? 'dd-MMMM-yyyy').format(value ?? DateTime.now());
}
dateFormatDateTimeUtc({String? format, DateTime? value}) {
  return DateFormat(format ?? 'dd-MMMM-yyyy').format(value?.toLocal() ?? DateTime.now());
}

dateFormatString({String? format, String? value}) {
  return DateFormat(format ?? 'dd-MMMM-yyyy').format(DateTime.parse(value!));
}

String dateFormatOrderHistory({String? format, String? value}) {
  final DateFormat dateFormat = DateFormat(format ?? 'dd-MMMM-yyyy');
  final DateTime parsedDate =
      dateFormat.parse(value ?? DateTime.now().toString());
  final String dayWithOrdinal = _getDayWithOrdinal(parsedDate.day);
  return dateFormat
      .format(parsedDate)
      .replaceFirst('${parsedDate.day}', dayWithOrdinal);
}

String _getDayWithOrdinal(int day) {
  if (day >= 11 && day <= 13) {
    return '${day}th';
  } else if (day % 10 == 1) {
    return '${day}st';
  } else if (day % 10 == 2) {
    return '${day}nd';
  } else if (day % 10 == 3) {
    return '${day}rd';
  } else {
    return '${day}th';
  }
}

Future<String> getJsonFile(String path) async {
  ByteData byte = await rootBundle.load(path);
  var list = byte.buffer.asUint8List(byte.offsetInBytes, byte.lengthInBytes);
  return utf8.decode(list);
}
//helper function
void setMapStyle(String mapStyle, GoogleMapController mapController) {
  mapController.setMapStyle(mapStyle);
}
Widget freeDeliveryText({price}) {
  return Text.rich(TextSpan(
      text: '${TextFile.freeDelivery.tr} -',
      style: AppStyle.txtDMSansMedium12.copyWith(color: Colors.black),
      children: [
        TextSpan(
            text: TextFile.above.tr, style: AppStyle.txtDMSansRegular12Gray600),
        TextSpan(
          text:
          ' Rs.$price ',
        ),
        TextSpan(
            text: TextFile.aboveHindi.tr, style: AppStyle.txtDMSansRegular12Gray600),
      ]));
}
String getDaySuffix(int day) {
  if (day >= 11 && day <= 13) {
    return 'th';
  }
  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}

String formatDateWithSuffix({String? formattedDateString}) {
  final parsedDate = DateTime.parse(formattedDateString??DateTime.now().toString());
  final day = parsedDate.day;
  final formattedDay = '$day${getDaySuffix(day)}';
  final formattedMonth = DateFormat('MMM').format(parsedDate);
  return '$formattedDay $formattedMonth';
}

String formatItemList(List<OrderItemDataModel> items) {
  if (items.isEmpty) {
    return "No items";
  }
  List itemNames = items.take(3).map((element) => element.itemName).toList();
  String formattedString = itemNames.join(", ");
  if (items.length > 3) {
    final remainingCount = items.length - 1;
    formattedString += " +$remainingCount";
  }
  return formattedString;
}
String truncateText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return '${text.substring(0, maxLength)}...';
  }
}

Widget willPopScopeBackWidget({child}){
  return WillPopScope(child: child, onWillPop: () {
    Get.back(result:  true);
    return Future.value(true);
  },);
}