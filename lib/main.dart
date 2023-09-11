import 'package:responsive_framework/responsive_framework.dart';
import 'app_values/export.dart';

CustomLoader? customLoader;
GetStorage localStorage = GetStorage();
DatabaseHelper databaseHelper = DatabaseHelper();

void main() async {
  customLoader = CustomLoader();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  if (GetPlatform.isWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyB6ap-BbnnzNFjne3-2r1B3-YYXkalLcEY",
            appId: "1:613352528847:web:ecb783e7a7ca197fba90ba",
            messagingSenderId: "613352528847",
            storageBucket: "foodguru-f0285.appspot.com",
            projectId: "foodguru-f0285"));
  }else if(GetPlatform.isDesktop){

  } else {
    await Firebase.initializeApp();
  }



  if (!GetPlatform.isWeb) {
  await databaseHelper.dpOpen();
    addDataToLocalDB();
  }

  debugPrint(PreferenceManger().getLanguage().toString());
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: ColorConstant.greenA700,
    statusBarIconBrightness:
        GetPlatform.isAndroid ? Brightness.light : Brightness.light,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

addDataToLocalDB() async {
  if (DataSettings.isDBActive == true) {
    await CartNetwork.cartTableCreate();
    await FavouriteNetwork.favoriteTableCreate();
    await OrderItemNetwork.orderItemTableCreate();
    await AddressNetwork.addressTableCreate();
    await FeedbackNetwork.feedBackTableCreate();
    await OrderNetwork.orderTableCreate();
    await OrderItemNetwork.orderItemTableCreate();
    _userSignup();
    await LanguageNetwork.insertLanguage(
      onSuccess: () {},
    );
    await RestaurantNetwork.insertRestaurant(
      onSuccess: () {},
    );
    await CategoriesNetwork.insertCategory(
      onSuccess: () {},
    );
    await CategoriesMainNetwork.insertCategoriesMain(
      onSuccess: () {},
    );
    await RestaurantMainNetwork.insertRestaurantMain(
      onSuccess: () {},
    );
    await OutletMainNetwork.insertOutletMain(
      onSuccess: () {},
    );
    await OutletNetwork.insertOutlet(
      onSuccess: () {},
    );
    await OutletImagesNetwork.insertOutletImages(
      onSuccess: () {},
    );
    await ItemMainNetwork.insertItemsMain(
      onSuccess: () {},
    );
    await ItemNetwork.insertItems(
      onSuccess: () {},
    );
    await ItemImagesNetwork.insertItemImages(
      onSuccess: () {},
    );
    await NutritionMainNetwork.insertNutritionMain(
      onSuccess: () {},
    );
    await NutritionNetwork.insertNutritionData(
      onSuccess: () {},
    );
    await DineInTableMainNetwork.insertDineInTableMain(
      onSuccess: () {},
    );
    await DineInTableNetwork.insertDineInTable(
      onSuccess: () {},
    );
    await CouponMainNetwork.insertCouponMain(
      onSuccess: () {},
    );
    await CouponNetwork.insertCoupon(
      onSuccess: () {},
    );
    await CancelReasonMainNetwork.insertCancelReasonMain(
      onSuccess: () {},
    );
    await CancelReasonNetwork.insertCancelReason(
      onSuccess: () {},
    );
    await NotificationTypeNetwork.insertNotificationType(
      onSuccess: () {},
    );
    _selectedLanguage();
  }
}

_userSignup() {
  UserDbModel userDbModel = UserDbModel(
    firstName: 'Andrew',
    lastName: 'Symmonds',
    email: 'andrew@gmail.com',
    phone: '78962311564',
    deviceType: 'Android',
    password: '12345678',
    loginType: typeEmail,
    imageUrl: 'imageUrlUpload',
  );
  signUp(
    isShowToast: false,
    userDbModel: userDbModel,
    onSuccess: () async {},
  );
}

_selectedLanguage() async {
  List<LanguageModel> languageList;
  await LanguageNetwork.getAllLanguageList().then((value) {
    var defaultLanguageId;
    languageList = value ?? [];
    int index = languageList.indexWhere(
        (element) => element.locale == TranslationService.locale?.languageCode);
    if (index == -1) {
      PreferenceManger().setLanguage(DataSettings.languageCode);
      int index1 = languageList.indexWhere((element) =>
          element.locale == PreferenceManger().getLanguage()?.languageCode);
      if (index1 != -1) {
        defaultLanguageId = languageList[index1].id;
        PreferenceManger().setLanguageId(defaultLanguageId);
        debugPrint(PreferenceManger().getLanguageId().toString());
      }
      Get.updateLocale(PreferenceManger().getLanguage()!);
    } else {
      PreferenceManger().setLanguageId(languageList[index].id);
      PreferenceManger().setLanguage(languageList[index].locale);
      Get.updateLocale(PreferenceManger().getLanguage()!);
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: GetMaterialApp(builder: (context, child) => ResponsiveBreakpoints.builder(child: child!, breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ]),
            debugShowCheckedModeBanner: false,
            defaultTransition: Transition.cupertino,
            theme: ThemeData(
                platform: TargetPlatform.iOS,
                backgroundColor: ColorConstant.gray50,
                textSelectionTheme: TextSelectionThemeData(
                    selectionHandleColor: ColorConstant.greenA700,
                    selectionColor: ColorConstant.greenA700.withOpacity(0.4),
                    cursorColor: ColorConstant.greenA700)),
            enableLog: true,
            translations: TranslationService(),
            locale: TranslationService.locale,
            initialBinding: SplashBindings(),
            fallbackLocale: TranslationService.fallbackLocale,
            logWriterCallback: AppLogger.write,
            initialRoute: AppPages.initial,
            getPages: AppPages.routes,
          ),
        );
      },
    );
  }
}
