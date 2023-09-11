import 'package:foodguru/app_values/export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String? title;
  Function()? onBackPress;
  Widget? leading;
  Widget? titleWidget;
  double? leadingWidth;
  List<Widget>? actions;
  Color? backgroundColor;
  Color? titleColor;
  Color? iconColor;
  bool? centerTitle;
  Brightness? iosStatusBarBrightness;
  var result;

  CustomAppBar(
      {this.title,
      this.titleWidget,
      this.actions,
      this.result,
      this.backgroundColor,
      this.centerTitle,
      this.leading,
      this.iconColor,
      this.onBackPress,
      this.iosStatusBarBrightness=Brightness.light,
      this.titleColor,
      this.leadingWidth});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness:iosStatusBarBrightness?? Brightness.light,
          statusBarIconBrightness:
              GetPlatform.isAndroid ? Brightness.light : Brightness.light),
      backgroundColor: Colors.transparent,
      leadingWidth: leadingWidth,
      elevation: 0,titleSpacing: 0,
      leading: leading ??
          GetInkwell(
            onTap: onBackPress ??
                () {
                  Get.back(result:result );
                },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: iconColor??Colors.black,
              size: height_22,
            ),
          ),
      centerTitle: centerTitle ?? true,
      actions: actions ?? [],
      title: titleWidget ??
          Text(title ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: AppStyle.txtDMSansBold24Black900.copyWith(color: titleColor??ColorConstant.black900)),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(GetPlatform.isAndroid?height_45:height_40);
}
