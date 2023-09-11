import 'package:flutter/cupertino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../app_values/export.dart';


// Estimated from the iPhone Simulator running iOS 15
final CupertinoDynamicColor _kBackgroundColor =
    CupertinoDynamicColor.withBrightness(
  color: CupertinoColors.white,
  darkColor: CupertinoColors.systemGrey6.darkColor,
);

final CupertinoDynamicColor _kActiveDotColor =
    CupertinoDynamicColor.withBrightness(
  color: ColorConstant.greenA700,
  darkColor: ColorConstant.greenA700,
);
final CupertinoDynamicColor _kInactiveDotColor =
    CupertinoDynamicColor.withBrightness(
  color: CupertinoColors.systemGrey2.color,
  darkColor: CupertinoColors.systemGrey2.darkColor,
);

const Size _kDotSize = Size(8, 8);

final BorderRadius _bottomButtonBorderRadius = BorderRadius.circular(15);
const EdgeInsets _kBottomButtonPadding = EdgeInsets.only(
  left: 22,
  right: 22,
  bottom: 60,
);

class CupertinoOnboarding extends StatefulWidget {
  CupertinoOnboarding({
    required this.pages,
    this.backgroundColor,
    this.bottomButtonChild,
    this.bottomButtonBorderRadius,
    this.bottomButtonPadding = _kBottomButtonPadding,
    this.widgetAboveBottomButton,
    this.pageTransitionAnimationDuration = const Duration(milliseconds: 500),
    this.pageTransitionAnimationCurve = Curves.easeInOut,
    this.onPressed,
    this.onPressedOnLastPage,
    this.skipTextChange,
    this.onPressedSkipButton,
    super.key,
  });

  final List<Widget> pages;

  final Color? backgroundColor;

  final Widget? bottomButtonChild;

  final BorderRadius? bottomButtonBorderRadius;

  final EdgeInsets bottomButtonPadding;

  final Widget? widgetAboveBottomButton;

  final Duration pageTransitionAnimationDuration;

  final Curve pageTransitionAnimationCurve;
  final String? skipTextChange;

  final VoidCallback? onPressed;

  final VoidCallback? onPressedOnLastPage;

  final VoidCallback? onPressedSkipButton;

  @override
  State<CupertinoOnboarding> createState() => _CupertinoOnboardingState();
}

class _CupertinoOnboardingState extends State<CupertinoOnboarding> {
  final PageController _pageController = PageController();

  int _currentPage = 0;
  double _currentPageAsDouble = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _pageController.addListener(() {
        setState(() {
          _currentPageAsDouble = _pageController.page!;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: widget.backgroundColor ?? _kBackgroundColor.resolveFrom(context),
      child: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageConstant.iconsIcSplashBg),fit: BoxFit.cover)),
          child: Column(
            children: [
              Container(
                height: Get.height*0.65,
                child: PageView(
                  physics: const BouncingScrollPhysics(),
                  controller: _pageController,
                  children: widget.pages,
                  onPageChanged: (page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                ),
              ),
              if (widget.pages.length > 1)
                AnimatedSmoothIndicator(
                  activeIndex: _currentPage,
                  count: widget.pages.length,
                  effect: CustomizableEffect(
                      dotDecoration: DotDecoration(
                        color: _kInactiveDotColor.resolveFrom(context),
                        width: height_6,
                        height: height_6,
                        borderRadius: BorderRadius.circular(radius_10)
                      ),
                      activeDotDecoration: DotDecoration(
                          color: _kActiveDotColor.resolveFrom(context),
                          width: height_8,
                          height: height_8,
                          borderRadius: BorderRadius.circular(radius_10)
                      ),

                      ),
                ),
              if (widget.widgetAboveBottomButton != null)
                widget.widgetAboveBottomButton!
              else
                const SizedBox(height: 10),
              Center(
                child: Padding(
                  padding: widget.bottomButtonPadding,
                  child: Column(
                    children: [
                      CustomButton(
                        height: 45,
                        width: getSize(width),
                        shape: ButtonShape.RoundedBorder22,
                        text: _currentPage > 1
                            ? TextFile.getStartedTitle.tr
                            : TextFile.nextTitle.tr,
                        margin: getMargin(top: height_25),
                        variant: ButtonVariant.OutlineBlack9003f,
                        fontStyle: ButtonFontStyle.InterSemiBold18,
                        onTap: _currentPage > 1
                            ? widget.onPressedOnLastPage
                            : widget.onPressed ?? _animateToNextPage,
                      ),
                      GestureDetector(
                          onTap: _currentPage < 2
                              ? widget.onPressedSkipButton
                              : () {},
                          child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: _currentPage <= 1
                                  ? Text(TextFile.skipTitle.tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtInterRegular14Gray800)
                                  : Text("",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style:
                                          AppStyle.txtInterRegular14Gray800))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _animateToNextPage() async {
    await _pageController.nextPage(
      duration: widget.pageTransitionAnimationDuration,
      curve: widget.pageTransitionAnimationCurve,
    );
  }
}
