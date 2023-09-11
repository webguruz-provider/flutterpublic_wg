import 'package:foodguru/data/response/status.dart';

import '../../model/dummy_onboarding_model.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse(this.status, this.data, this.message);

  ApiResponse.loading() : status = Status.LOADING;

  ApiResponse.completed(OnBoardingModel value) : status = Status.COMPLETED;

  ApiResponse.error(String string) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data: $data";
  }
}
