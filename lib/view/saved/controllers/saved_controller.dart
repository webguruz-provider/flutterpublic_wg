import 'package:foodguru/app_values/export.dart';

class SavedController extends GetxController{

  List<ItemModel> itemsList=[];
@override
  void onReady() {
  getFavouritesList();
  print('isfav--1');
    super.onReady();
  }
  getFavouritesList() async {
    await ItemNetwork.getFavouritesItemsList().then((value) {
      itemsList=value!;
    });
    update();
  }

}