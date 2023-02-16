import 'package:soon_sak/utilities/index.dart';

part 'controllerResource/search_content_view_model.part.dart'; // 컨텐츠 검색
part 'controllerResource/register_video_link_view_model.part.dart'; // 영상 링크 등록
part 'controllerResource/confirm_curation_view_model.part.dart'; // 등록 컨텐츠 확인

class RegisterViewModel extends BaseViewModel {
  RegisterViewModel(this._searchUseCase, this.validateVideoUrlUseCase,
      {required contentType})
      : selectedContentType = contentType;

  /* Variables */
  // 선택된 컨텐츠 타입
  final ContentType selectedContentType;

  // 등록 컨텐츠 진행 단계
  final RxList<bool> selectedSteps = <bool>[true, false, false].obs;

  // 현재 pageView Index
  int get currentPageViewIndex => pageViewController.page?.toInt() ?? 0;

  // 등록 진행중 컨텐츠 데이터
  Rxn<Content> curationContent = Rxn();

  /* Controllers */
  late PageController pageViewController;

  /* UseCases */
  final SearchPagedContentUseCase _searchUseCase;
  final SearchValidateUrlUseCase validateVideoUrlUseCase;

  /* Intents */
  // PageIndicator 토글 로직
  void togglePageIndicatorIndex(int pageIndex) {
    for (int i = 0; i < selectedSteps.length; i++) {
      if (i == pageIndex) {
        selectedSteps[i] = true;
      } else {
        selectedSteps[i] = false;
      }
    }
  }

  // 등록 진행 컨텐츠 데이터 업데이트
  Future<void> submitContent() async {
    AlertWidget.animatedToast('등록 절차를 거친 뒤 컨텐츠가 등록됩니다',
        isUsedOnTabScreen: true);
  }

  /// 하단 고정 버튼이 클릭 시
  /// pageView 현재 인덱스에 따라 동작을 다르게 함.
  Future<void> onFloatingStepBtnTapped() async {
    switch (currentPageViewIndex) {
      case 0:
        await pageViewController.animateToPage(
          1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        togglePageIndicatorIndex(1);
        break;
      case 1:
        unawaited(setContentInfo());
        unawaited(pageViewController.animateToPage(
          2,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        ));
        togglePageIndicatorIndex(2);
        break;
      case 2:
        Get.back();
        submitContent();
    }
  }

  // 뒤로가기 버튼 클릭 시
  /// pageView 현재 인덱스에 따라 동작을 다르게 함.
  void onBackBtnTapped() {
    switch (currentPageViewIndex) {
      case 0:
        Get.back();
        break;
      case 1:
        contentFormFocusNode.unfocus();
        togglePageIndicatorIndex(0);
        pageViewController.animateToPage(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        break;
      case 2:
        videoFormFocusNode.unfocus();
        togglePageIndicatorIndex(1);
        pageViewController.animateToPage(
          1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        break;
    }
  }

  // 입력된 컨텐츠 정보 저장
  Future<void> setContentInfo() async {
    final videoId = validateVideoUrlUseCase.selectedVideoId;
    final channelId = validateVideoUrlUseCase.selectedChannelId;
    final response = await YoutubeMetaData.yt.channels.get(channelId);

    curationContent.value = Content(
      id: selectedContentDetail!.id,
      type: selectedContentDetail?.type,
      videoId: videoId,
      youtubeVideo: YoutubeVideo(
        channelName: response.title,
        channelImg: response.logoUrl,
        subscriberCount: response.subscribersCount,
      ),
      detail: ContentDetail(
        title: selectedContentDetail?.detail?.title,
        posterImgUrl: selectedContentDetail?.detail?.posterImgUrl,
        releaseDate: selectedContentDetail?.detail?.releaseDate,
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();

    pagingController.addPageRequestListener((pageKey) {
      loadSearchedContentListByPaging();
    });

    pageViewController = PageController();
  }
}