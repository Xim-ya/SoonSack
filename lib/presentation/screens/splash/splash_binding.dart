import 'package:soon_sak/app/di/custom_binding.dart';
import 'package:soon_sak/utilities/index.dart';

class SplashBinding extends CustomBindings {
  @override
  void dependencies() {
    // Get.put(UserService(Get.find(), Get.find()));
    // Get.put(LocalStorageService(), permanent: true);
    // Get.put(ContentService(Get.find(), Get.find()), permanent: true);
    // Get.lazyPut(()=> SplashViewModel(Get.find(), Get.find(), Get.find(), Get.find()));
    // Get.put(SplashViewModel(Get.find(), Get.find(), Get.find(), Get.find()));

    // GetIt.I.registerSingleton<SplashViewModel>(SplashViewModel());
  }

  @override
  void unRegister() {}

  @override
  void unRegisterDependencies() {}
}
