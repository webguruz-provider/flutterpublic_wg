import 'package:foodguru/app_values/export.dart';

class LocationServiceDisabledDialog extends StatelessWidget {
  const LocationServiceDisabledDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width,
        margin: EdgeInsets.all(margin_20),
        padding: EdgeInsets.all(margin_15),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: ColorConstant.greenA700, width: width_2),
            borderRadius: BorderRadius.circular(radius_10)),
        child: Material(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _locationIcon(),
              _locationServiceDisabledText(),
              _appNeedsLocationAccessText(),
              _noThingsAndSettingsButton(),
            ],
          ),
        ),
      ),
    );
  }

  _locationIcon() {
    return Icon(
      Icons.location_off_outlined,
      size: width_100,
      color: ColorConstant.greenA700,
    );
  }

  _locationServiceDisabledText() {
    return Text(
      'Location Service is Disabled',
      textAlign: TextAlign.center,
      style: AppStyle.txtDMSansBold14.copyWith(color: ColorConstant.greenA700),
    ).marginOnly(top: margin_10);
  }

  _appNeedsLocationAccessText() {
    return Text(
      'Food guru needs location access to your location to show restaurants near you. Please enable it from Settings',
      textAlign: TextAlign.center,
      style: AppStyle.txtDMSansRegular12Gray60001,
    ).marginOnly(top: margin_10);
  }

  _noThingsAndSettingsButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GetInkwell(
            onTap: () {
              Get.back(result: true);
            },
            child: Text(
              'No thanks',
              style: AppStyle.txtDMSansBold14,
            )),
        GetInkwell(
            onTap: () async {

              try{
                await Geolocator.openLocationSettings();
                locationSettingsClosedCallback();
              }catch(e){
                debugPrint("Error");
              }




            },
            child: Text(
              'Open Settings',
              style: AppStyle.txtDMSansBold14,
            ).marginOnly(left: margin_20)),
      ],
    ).marginOnly(top: margin_20);
  }
  void locationSettingsClosedCallback() {
    print('Location settings screen closed');
    Get.back(result: true);
  }
}
