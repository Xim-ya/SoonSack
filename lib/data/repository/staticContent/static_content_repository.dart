import 'package:uppercut_fantube/domain/model/content/home/static_content_keys.dart';
import 'package:uppercut_fantube/domain/model/content/home/top_ten_contents_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

abstract class StaticContentRepository {
  // 홈 상단 배너 컨텐츠 정보 호출
  Future<Result<BannerModel>> loadBannerContentList();

  // Top 10 컨텐츠 정보 호출
  Future<Result<TopTenContentsModel>> loadTopTenContent();

  // 고정 컨텐츠 리스트 키 값 호출
  Future<Result<StaticContentKeys>> loadStaticContentKeys();

  static StaticContentRepository get to => Get.find();
}
