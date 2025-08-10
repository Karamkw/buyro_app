import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ReportController extends GetxController {
  var selectedReason = RxnString();

  void selectReason(String? reason) {
    selectedReason.value = reason;
  }
}
