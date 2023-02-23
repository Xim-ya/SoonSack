import 'package:soon_sak/utilities/index.dart';

class SearchScaffoldController extends BaseViewModel
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;
  late final ScrollController scrollController;

  /* Variables */
  ContentType _selectedTabType = ContentType.tv; // 선택된 탭 (컨텐츠 타입)

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 2, vsync: this);
    scrollController = ScrollController();

    /// 탭 인덱스가 변경될 때 마다
    /// 아래 1,2 메소들 실행
    tabController.addListener(
      () {
        print("arang!@#!@#");
        // 1. 타입별로 Api을 하기 위해 컨텐츠 타입을 변경.
        if (tabController.index == 0) {
          _selectedTabType = ContentType.tv;
        } else {
          _selectedTabType = ContentType.movie;
          // if (ContentService.to.totalListOfRegisteredMovieContent.value ==
          //     null) {
          //   // TODO: 검색 로직 리팩토링 진행시 해당 부분 대응 필요
          //   // ContentService.to.fetchAl lOfRegisteredMovieContent();
          // }
        }

        /// 2. paiginController 리셋
        /// 검색어가 없다면 refresh 하지 않음.
        if (SearchViewModel.to.searchedKeyword.isNotEmpty) {
          SearchViewModel.to.refreshPagingController();
        }
      },
    );
  }

  /* Getters */

  // 선택된 탭 (컨텐츠 타입) - [SearchViewModel]에서 사용.
  static ContentType get selectedTabType =>
      Get.find<SearchScaffoldController>()._selectedTabType;
}
