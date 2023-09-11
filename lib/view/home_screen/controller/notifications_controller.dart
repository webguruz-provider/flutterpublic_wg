import 'package:foodguru/app_values/export.dart';

class NotificationsController extends GetxController {
  var count=0;
  RxList<NotificationModel> notificationList = <NotificationModel>[].obs;

  @override
  void onInit() {
    fetchNotificationList();
    super.onInit();
  }

  notficationListSeprate() {
    notificationList.sort((a, b) => b.createdOn!.compareTo(a.createdOn!),);
    notificationList.forEach((element) {
      DateTime date=DateTime.parse(element.createdOn!);
      if(date.day==DateTime.now().day&&
          date.month==DateTime.now().month&&
          date.year==DateTime.now().year){
        count++;
      }
    }
    );
    debugPrint(count.toString());

  }



  fetchNotificationList() async {
    await NotificationNetwork.getNotificationList().then((value) {
      notificationList.value=value??[];
      notficationListSeprate();
    });
  }
}
