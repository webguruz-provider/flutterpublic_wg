import 'package:foodguru/app_values/export.dart';


class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;
  final Widget? particularResturantWidget;
  final Widget? commonDetails;
  final bool? extraSpace ;

  CustomSliverDelegate({
    required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
    this.particularResturantWidget,
    this.commonDetails,
    this.extraSpace = false
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 2 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return Stack(
      children: [
        Container(
          height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: margin_15),
          child: commonDetails,
        ),
        Align(alignment: Alignment.bottomCenter,
          child: Opacity(
            opacity: percent,
            child: Container(
              // color: Colors.amber,
              child: particularResturantWidget,
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / height_2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
