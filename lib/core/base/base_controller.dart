import 'package:get/get.dart';


/// Base controller class which uses in Getx operations.
///
///
///
enum ViewState {
  idle,
  busy,
  retrieved,
  error,
}


class BaseController extends GetxController {
  var viewState = ViewState.idle.obs;
  RxBool isBusy = false.obs;

  void setBusy(bool value) {
    isBusy.value = value;
  }

  void setState(ViewState newState) {
    viewState.value = newState;
  }
}
