import 'package:foodguru/app_values/export.dart';

class AppPages {
  static const initial = AppRoutes.splashScreen;

  static final routes = [
    GetPage(
      name: AppRoutes.splashScreen,
      page: () =>  const SplashScreen(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: AppRoutes.onBoardingScreen,
      page: () =>  const OnBoardingViewScreen(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: AppRoutes.signupScreen,
      page: () => SignUpScreen(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => const LoginScreen(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPasswordScreen,
      page: () => const ForgotPasswordScreen(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: AppRoutes.otpVerificationScreen,
      page: () => OtpVerificationScreen(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: AppRoutes.resetPasswordScreen,
      page: () => const ResetPasswordScreen(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => const HomeScreen(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: AppRoutes.mainScreen,
      page: () => const MainScreen(),
      binding: HomeBindings(),
    ),
  GetPage(
      name: AppRoutes.categoriesScreen,
      page: () => const CategoriesScreen(),
      binding: HomeBindings(),
    ),
  GetPage(
      name: AppRoutes.itemListScreen,
      page: () =>  ItemListScreen(),
      binding: HomeBindings(),
    ),
  GetPage(
      name: AppRoutes.searchScreen,
      page: () => const SearchScreen(),
      binding: HomeBindings(),
    ),
  GetPage(
      name: AppRoutes.searchedItemListScreen,
      page: () => const SearchedItemListScreen(),
      binding: HomeBindings(),
    ),
  GetPage(
      name: AppRoutes.searchedRestaurantListScreen,
      page: () => const SearchedRestaurantListScreen(),
      binding: HomeBindings(),
    ),
  GetPage(
      name: AppRoutes.itemDetailsScreen,
      page: () => const ItemDetailsScreen(),
      binding: HomeBindings(),
    ),
  GetPage(
      name: AppRoutes.restaurantDetailsScreen,
      page: () => const RestaurantDetailsScreen(),
      binding: HomeBindings(),
    ),
  GetPage(
      name: AppRoutes.savedScreen,
      page: () => const SavedScreen(),
      binding: SavedBindings(),
    ),
  GetPage(
      name: AppRoutes.cartScreen,
      page: () => const CartScreen(),
      binding: CartBindings(),
    ),
  GetPage(
      name: AppRoutes.billScreen,
      page: () => const BillScreen(),
      binding: CartBindings(),
    ),
  GetPage(
      name: AppRoutes.couponScreen,
      page: () => const CouponScreen(),
      binding: CartBindings(),
    ),
  GetPage(
      name: AppRoutes.addressListScreen,
      page: () => const AddressListScreen(),
      binding: CartBindings(),
    ),
  GetPage(
      name: AppRoutes.addAddressScreen,
      page: () => const AddAddressScreen(),
      binding: CartBindings(),
    ),
  GetPage(
      name: AppRoutes.paymentScreen,
      page: () => const PaymentScreen(),
      binding: PaymentBindings(),
    ),
  GetPage(
      name: AppRoutes.addCardScreen,
      page: () => const AddCardScreen(),
      binding: PaymentBindings(),
    ),
  GetPage(
      name: AppRoutes.addMoneyScreen,
      page: () => const AddMoneyScreen(),
      binding: PaymentBindings(),
    ),
  GetPage(
      name: AppRoutes.orderSuccessScreen,
      page: () => const OrderSuccessScreen(),
      binding: PaymentBindings(),
    ),
  GetPage(
      name: AppRoutes.profileScreen,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),
  GetPage(
      name: AppRoutes.orderHistoryScreen,
      page: () => const OrderHistoryScreen(),
      binding: ProfileBinding(),
    ),
  GetPage(
      name: AppRoutes.orderDetailsScreen,
      page: () => const OrderDetailsScreen(),
      binding: ProfileBinding(),
    ),
  GetPage(
      name: AppRoutes.cancelOrderScreen,
      page: () => const CancelOrderScreen(),
      binding: ProfileBinding(),
    ),
  GetPage(
      name: AppRoutes.walletScreen,
      page: () => const WalletScreen(),
      binding: ProfileBinding(),
    ),
  GetPage(
      name: AppRoutes.pointsScreen,
      page: () => const PointsScreen(),
      binding: ProfileBinding(),
    ),
  GetPage(
      name: AppRoutes.changeLanguageScreen,
      page: () => const ChangeLanguageScreen(),
      binding: ProfileBinding(),
    ),
  GetPage(
      name: AppRoutes.faqScreen,
      page: () => const FaqScreen(),
      binding: ProfileBinding(),
    ),
  GetPage(
      name: AppRoutes.trackOrderScreen,
      page: () => const TrackOrderScreen(),
      binding: OrderBindings(),
    ),
  GetPage(
      name: AppRoutes.editProfileScreen,
      page: () => const EditProfileScreen(),
      binding: ProfileBinding(),
    ),
  GetPage(
      name: AppRoutes.feedbackScreen,
      page: () => const FeedbackScreen(),
      binding: ProfileBinding(),
    ),
  GetPage(
      name: AppRoutes.aboutUsScreen,
      page: () => const AboutUsScreen(),
      binding: ProfileBinding(),
    ),
  GetPage(
      name: AppRoutes.staticPagesScreen,
      page: () => const StaticPagesScreen(),
      binding: ProfileBinding(),
    ),
  GetPage(
      name: AppRoutes.contactUsScreen,
      page: () => const ContactUsScreen(),
      binding: ProfileBinding(),
    ),
  GetPage(
      name: AppRoutes.dineInListScreen,
      page: () => const DineInListScreen(),
      binding: DineInBinding(),
    ),
  GetPage(
      name: AppRoutes.dineInDetailsScreen,
      page: () => const DineInDetailsScreen(),
      binding: DineInBinding(),
    ),
  GetPage(
      name: AppRoutes.menuScreen,
      page: () => const MenuScreen(),
      binding: DineInBinding(),
    ),
  GetPage(
      name: AppRoutes.dineInBookingDetailScreen,
      page: () => const DineInBookingDetailScreen(),
      binding: DineInBinding(),
    ),
  GetPage(
      name: AppRoutes.dineInSelectRestaurantScreen,
      page: () => const DineInSelectRestaurantScreen(),
      binding: DineInBinding(),
    ),
  GetPage(
      name: AppRoutes.notificationsScreen,
      page: () => const NotificationsScreen(),
      binding: HomeBindings(),
    ),
  GetPage(
      name: AppRoutes.dineInBookTableScreen,
      page: () =>  DineInBookTableScreen(),
      binding: DineInBinding(),
    ),
  GetPage(
      name: AppRoutes.specialOffersScreen,
      page: () =>  const SpecialOffersScreen(),
      binding: HomeBindings(),
    ),
  ];
}
