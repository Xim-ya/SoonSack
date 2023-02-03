import 'package:uppercut_fantube/presentation/screens/quration/localWidget/start_quration_button.dart';
import 'package:uppercut_fantube/utilities/extensions/random_list_item_extension.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class QurationViewModel extends BaseViewModel {
  /* Variables */
  late final RandomImg randomContentImg;

  /* Intent */
  // 컨텐츠 등록 스크린으로 이동
  void routeToRegister({required ContentType contentType}) {
    Get.toNamed(AppRoutes.register, arguments: contentType);
  }

  String randomImgGenerator(ContentType contentType) {
    final List<String> imgPathList =
        contentType.isTv ? tvImgPathList : movieImgPathList;
    String randomImgPath = imgPathList.randomItem();
    return randomImgPath;
  }

  @override
  void onInit() {
    super.onInit();

    randomContentImg = RandomImg(
        tvImgPath: tvImgPathList.randomItem(),
        movieImgPath: movieImgPathList.randomItem());
  }
}

class RandomImg {
  final String tvImgPath;
  final String movieImgPath;

  RandomImg({required this.tvImgPath, required this.movieImgPath});
}
