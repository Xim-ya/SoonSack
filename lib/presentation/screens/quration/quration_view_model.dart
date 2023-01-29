import 'package:uppercut_fantube/utilities/index.dart';

class QurationViewModel extends BaseViewModel {



  /* Intent */

  // 컨텐츠 등록 스크린으로 이동
  void routeToRegister({required ContentType contentType}) {
    Get.toNamed(AppRoutes.register, arguments: contentType);
  }
}