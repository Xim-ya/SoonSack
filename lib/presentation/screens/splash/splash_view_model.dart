import 'package:soon_sak/domain/service/user_service.dart';
import 'package:soon_sak/utilities/index.dart';

class SplashViewModel extends BaseViewModel {
  SplashViewModel(this._userService);

  final UserService _userService;


   // 라우팅 핸들러
  Future<void> handleRoute() async {
    if (UserService.to.isUserSignIn) {
      await Get.offAllNamed(AppRoutes.tabs);
    } else {
      await Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  void onReady() {
    super.onReady();

    handleRoute();
  }
}
