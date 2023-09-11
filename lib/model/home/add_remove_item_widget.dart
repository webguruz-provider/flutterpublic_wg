import 'package:foodguru/app_values/export.dart';

class AddRemoveItemWidget extends StatelessWidget {
  Function()? onRemoveTap;
  Function()? onAddTap;
  int? quantity;

  AddRemoveItemWidget({this.quantity, this.onAddTap, this.onRemoveTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GetInkwell(
            onTap: onRemoveTap ?? () {},
            child: AssetImageWidget(
              ImageConstant.imagesIcRemove,
              width: width_20,
            )),
        Container(
            alignment: Alignment.center,
            width: width_30,
            child: Text('$quantity',
                style: AppStyle.txtDMSansRegular14
                    .copyWith(color: ColorConstant.greenA700))),
        GetInkwell(
            onTap: onAddTap ?? () {},
            child: AssetImageWidget(
              ImageConstant.imagesIcAdd,
              width: width_20,
            )),
      ],
    );
  }
}
