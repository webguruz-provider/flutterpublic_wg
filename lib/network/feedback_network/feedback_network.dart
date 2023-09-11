import 'package:foodguru/app_values/export.dart';

class FeedbackNetwork{
  static Future<void> feedBackTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableFeedback,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableFeedback} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnOrderId} INTEGER,
      ${DatabaseValues.columnItemId} INTEGER,
      ${DatabaseValues.columnUserId} INTEGER,
      ${DatabaseValues.columnOutletId} INTEGER,
      ${DatabaseValues.columnRatingGiven} DOUBLE,
      ${DatabaseValues.columnFeedback} TEXT,
      ${DatabaseValues.createdOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<void> addFeedback(
      {required int itemId,
        required double ratingGiven,
        required int orderId,
        required int outletId,
        required String feedback,
        Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
        Map<String, dynamic> map = <String, dynamic>{
          DatabaseValues.columnItemId: itemId,
          DatabaseValues.columnOrderId: orderId,
          DatabaseValues.columnUserId: userDbModel.id,
          DatabaseValues.columnRatingGiven: ratingGiven,
          DatabaseValues.columnOutletId: outletId,
          DatabaseValues.columnFeedback: feedback,
        };
        await databaseHelper
            .insertItemMap(DatabaseValues.tableFeedback, model: map)
            .then((value) {
          showToast(TextFile.feedbackAddedSuccessfully.tr);
          onSuccess!();
        }).onError((error, stackTrace) {
          debugPrint(error.toString());
        });

    }
  }
}