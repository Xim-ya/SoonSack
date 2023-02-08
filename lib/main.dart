import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uppercut_fantube/app/config/theme_config.dart';
import 'package:uppercut_fantube/app/di/app_binding.dart';
import 'package:uppercut_fantube/app/routes/app_pages.dart';
import 'package:uppercut_fantube/utilities/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  runApp(const MyApp());
  print('=====run App');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('=====run Ap2');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Soon Sak',
      theme: ThemeConfig.basicTheme,
      getPages: AppPages.routes,
      initialBinding: AppBinding(),
      initialRoute: AppRoutes.login,
      builder: (context, child) {
        SizeConfig.to.init(context); // Size Config 초기화
        return EasyLoading.init()(context, child);
      },
    );
  }
}
