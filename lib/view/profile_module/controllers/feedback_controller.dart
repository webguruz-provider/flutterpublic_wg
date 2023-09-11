import 'package:foodguru/app_values/export.dart';
import 'package:foodguru/network/feedback_network/feedback_network.dart';

class FeedbackController extends GetxController {
  TextEditingController? feedBackController;
  RxList<OrderDataModel>ordersList=<OrderDataModel>[].obs;
  RxnString selectedFeedback = RxnString();
  Rxn<OrderDataModel> selectedOrder = Rxn<OrderDataModel>();
  RxList<OrderItemDataModel> selectedOrderItems=<OrderItemDataModel>[].obs;
  RxList<OrderModel> orderList = <OrderModel>[
    OrderModel(
        orderNo: 37,
        amount: 1490,
        orderPlacedOn: '2023-07-16 15:34:15',
        menuList: <MenuItemDataModel>[
          MenuItemDataModel(
              imageUrl: ImageConstant.imagesIcDosa,
              restaurantName: 'Sindhi Sweets',
              description: 'Spicy and Freshly Baked',
              discountedPrice: '200',
              dishName: 'Nachos',
              distance: 800,
              isFavourite: false,
              itemPrice: '550',
              pointsPerQuantity: '4',
              quantity: 1,
              isVeg: true,
              isAddedToCart: false,
              rating: '4.9'),
          MenuItemDataModel(
              imageUrl: ImageConstant.imagesIcDosa,
              restaurantName: 'Sindhi Sweets',
              description: 'Spicy and Freshly Baked',
              discountedPrice: '320',
              dishName: 'Shahi Paneer',
              distance: 400,
              isFavourite: false,
              quantity: 1,
              itemPrice: '450',
              pointsPerQuantity: '8',
              isVeg: false,
              isAddedToCart: false,
              rating: '4.5'),
          MenuItemDataModel(
              imageUrl: ImageConstant.imagesIcDosa,
              restaurantName: 'Gopal\'s Sweets',
              description: 'Spicy and Freshly Baked',
              discountedPrice: '150',
              dishName: 'Dosa',
              distance: 400,
              quantity: 1,
              isFavourite: false,
              itemPrice: '550',
              pointsPerQuantity: '4',
              isVeg: true,
              isAddedToCart: false,
              rating: '4.9'),
        ]),
    OrderModel(
        orderNo: 38,
        amount: 1300,
        orderPlacedOn: '2023-07-16 12:34:15',
        menuList: <MenuItemDataModel>[
          MenuItemDataModel(
              imageUrl: ImageConstant.imagesIcDosa,
              restaurantName: 'Sindhi Sweets',
              description: 'Spicy and Freshly Baked',
              discountedPrice: '200',
              dishName: 'Nachos',
              distance: 800,
              isFavourite: false,
              itemPrice: '550',
              pointsPerQuantity: '4',
              quantity: 1,
              isVeg: true,
              isAddedToCart: false,
              rating: '4.9'),
          MenuItemDataModel(
              imageUrl: ImageConstant.imagesIcDosa,
              restaurantName: 'Sindhi Sweets',
              description: 'Spicy and Freshly Baked',
              discountedPrice: '200',
              dishName: 'Nachos',
              distance: 800,
              isFavourite: false,
              itemPrice: '550',
              pointsPerQuantity: '4',
              quantity: 1,
              isVeg: true,
              isAddedToCart: false,
              rating: '4.9'),
          MenuItemDataModel(
              imageUrl: ImageConstant.imagesIcDosa,
              restaurantName: 'Sindhi Sweets',
              description: 'Spicy and Freshly Baked',
              discountedPrice: '320',
              dishName: 'Shahi Paneer',
              distance: 400,
              isFavourite: false,
              quantity: 1,
              itemPrice: '450',
              pointsPerQuantity: '8',
              isVeg: false,
              isAddedToCart: false,
              rating: '4.5'),
          MenuItemDataModel(
              imageUrl: ImageConstant.imagesIcDosa,
              restaurantName: 'Gopal\'s Sweets',
              description: 'Spicy and Freshly Baked',
              discountedPrice: '150',
              dishName: 'Dosa',
              distance: 400,
              quantity: 1,
              isFavourite: false,
              itemPrice: '550',
              pointsPerQuantity: '4',
              isVeg: true,
              isAddedToCart: false,
              rating: '4.9'),
        ]),
  ].obs;
  RxInt addedCount=0.obs;

  orderedItemsList(List<MenuItemDataModel> itemList) {
    List<String> dishNames = itemList.map((e) => e.dishName!).toList();
    String displayText;

    if (dishNames.length <= 3) {
      displayText = dishNames.join(', ');
    } else {
      final List<String> firstThree = dishNames.sublist(0, 3);
      final String remainingCount = (dishNames.length - 3).toString();
      displayText = '${firstThree.join(', ')} + $remainingCount';
    }
    return displayText;
  }

  RxList<String> feedBackItemList = <String>[
    'Good',
    'Excellent',
    'Not Satisfied',
    'Poor Quality',
  ].obs;

  @override
  void onInit() {
    feedBackController = TextEditingController();
    getAllOrders();
    super.onInit();
  }


  getAllOrders() async {
    await OrderNetwork.getAllOrders().then((value) async {
      ordersList.value=value??[];
      for (var element in ordersList)  {
        element.orderItemList=await OrderItemNetwork.getOrderItemsList(element.id).onError((error, stackTrace) {
          showToast(error.toString());
        });
        ordersList.refresh();
      }
    });
  }

  addFeedback() async {

  }
}
