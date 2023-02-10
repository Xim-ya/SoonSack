part of 'home_view_model.dart';

extension HomeViewModelPart on HomeViewModel {
  // 홈 스크린 상단 노출 컨텐츠
  List<BannerItem>? get topExposedContentList =>
      _bannerContent.value?.contentList;

  //상단 노출 컨텐츠 데이터 로드 여부
  bool get isTopExposedContentListLoaded =>
      _bannerContent.value?.isLoaded ?? false;

  // 선택된 배너 컨텐츠
  BannerItem get selectedTopExposedContent =>
      _bannerContent.value!.contentList![topExposedContentSliderIndex];

  TopTenContentsModel? get topTenContents => _topTenContents.value;
}
