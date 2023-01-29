import 'dart:async';
import 'package:uppercut_fantube/utilities/index.dart';

/// TODO: PAGING 고도화 로직 필요
/// Tabview를  제스처로 이동할 때 UX가 부자연스러움.
/// PAGING Controller를 두 개로 분리 필요. (메모리를 너무 많이 사용하는지 사전에 확인 필요)

class SearchViewModel extends BaseViewModel {
  SearchViewModel(this._pagingHandler);

  /* Variables */
  RxBool showRoundCloseBtn = false.obs; // 검색 앱바 'x' 버튼 노출여부
  Timer? _debounce; // 검색 api call 시간 딜레이

  /* Getters */
  TextEditingController get textEditingController =>
      _pagingHandler.textEditingController;
  PagingController<int, SearchedContent> get pagingController =>
      _pagingHandler.pagingController;
  String get searchedKeyword => _pagingHandler.searchedKeyword;


  /* Controllers */
  late FocusNode focusNode;


  /* UseCases */
  final PagingHandlerUseCase _pagingHandler;

  /* Intents */
  /// 검색된 컨텐츠 클릭 되었을 때
  /// 컨텐츠 등록 여부에 따라 다른 동작(1,2,3)을 실행
  void onSearchedContentTapped(
      {required SearchedContent content, required ContentType contentType}) {
    // 키보드 가리기
    focusNode.unfocus();

    final registeredValue = content.isRegisteredContent.value;
    // 1. isRegistered 데이터가 로그 안되었다면 toast 메세지를 띄움
    if (registeredValue == ContentRegisteredValue.isLoading) {
      AlertWidget.toast('잠시만 기다려주세요. 데이터를 로딩하고 있습니다');
      return;
    }

    // 2. 등록된 컨텐츠라면 상세 페이지로 이동
    if (registeredValue == ContentRegisteredValue.registered) {
      Get.toNamed(
        AppRoutes.contentDetail,
        arguments: ContentArgumentFormat(
          contentId: content.contentId,
          contentType: contentType,
          posterImgUrl: content.posterImgUrl!,
        ),
      );
    } else {
      // 3. 등록된 컨텐츠가 아니라면 유저에게 '요청해주세요' 다이어로그를 띄움.
      Get.dialog(AppDialog.dividedBtn(
        title: '미등록 컨텐츠\n[${content.title}]',
        description: '등록되어 있는 컨텐츠가 아닙니다\n큐레이션 요청을 해주시면\n 빠른 시일 내 등록을 완료할게요!',
        leftBtnContent: '나중에',
        rightBtnContent: '요청하기',
        // TODO: 실제 요청 로직 추가 필요
        onRightBtnClicked: Get.back,
        onLeftBtnClicked: Get.back,
      ));
    }
  }

  // 검색어 초기화 - 'X' 버튼이 클릭 되었을 때
  void resetSearchValue() {
    textEditingController.text = '';
    showRoundCloseBtn(false);
  }


  // 검색어가 입력되었을 때
  void onSearchChanged(String searchedKeyword) {
    // 'x' 버튼 노출 여부 로직
    if(searchedKeyword.isNotEmpty && showRoundCloseBtn.isFalse) {
      showRoundCloseBtn(true);
    }
    if(searchedKeyword.isEmpty && showRoundCloseBtn.isTrue) {
      showRoundCloseBtn(false);
    }

    if (_pagingHandler.isPagingAllowed) {
      // Debounce delay 설정
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce =
          Timer(const Duration(milliseconds: 300), pagingController.refresh);
    }
  }


  // 컨텐츠 리스트 호출 - (pagination logic 적용)
  Future<void> loadSearchedContentListByPaging() async {
    if (loading.isTrue) {
      return;
    }
    loading(true);
    await _pagingHandler.loadSearchedContentList(SearchScaffoldController.selectedTabType, checkContentRegistration: true);
    loading(false);
  }


  // Paging Controller 리셋
  void refreshPagingController() {
    pagingController.refresh();
  }



  @override
  void onInit() {
    super.onInit();

    pagingController.addPageRequestListener((pageKey) {
      loadSearchedContentListByPaging();
    });

    focusNode = FocusNode();

    // 등록된 Movie & Tv 컨텐츠 정보 호출
    ContentService.to.fetchAllOfRegisteredTvContent();
  }

  /* Getters */
  // Paging Controller 리셋, 탭이 onChanged 되었을 때 발동.
  static SearchViewModel get to => Get.find();
}

