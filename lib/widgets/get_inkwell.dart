import 'package:foodguru/app_values/export.dart';

class GetInkwell extends StatelessWidget {
  Function()? onTap;
  Widget? child;

  GetInkwell({this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap??() {

      },
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      splashColor: Colors.transparent,
      child: child,
    );
  }
}
