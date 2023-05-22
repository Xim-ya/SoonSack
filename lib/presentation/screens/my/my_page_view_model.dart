import 'dart:developer';
import 'package:soon_sak/utilities/index.dart';

class MyPageViewModel extends NewBaseViewModel {
  MyPageViewModel(
      {required UserRepository userRepository,
      required UserService userService})
      : _userService = userService,
        _userRepository = userRepository;

  /* Data Modules */
  final UserService _userService;
  final UserRepository _userRepository;

  /* Variables */
  UserCurationSummary? curationSummary; //  큐레이션 내역 요약 정보
  List<UserWatchHistoryItem>? watchHistoryList; // 시청 기록
  UserModel? userInfo;

  String? get displayName => userInfo?.displayName;

  /* Intents */
  // 설정 스크린으로 이동
  void routeToSetting() {
    Get.toNamed(AppRoutes.setting);
  }

  // youtubeApp 실행
  Future<void> launchYoutubeApp(
    UserWatchHistoryItem? selectedContent,
    int index,
  ) async {
    if (selectedContent?.videoId == null) {
      return AlertWidget.animatedToast('잠시만 기다려주세요. 데이터를 불러오고 있습니다.');
    }
    try {
      await launchUrl(
        Uri.parse(
          'https://www.youtube.com/watch?v=${selectedContent!.videoId}',
        ),
        mode: LaunchMode.externalApplication,
      );
      unawaited(
        AppAnalytics.instance.logEvent(
          name: 'playContent',
          parameters: {
            'myPage': selectedContent.originId,
          },
        ),
      );
    } catch (e) {
      await AlertWidget.animatedToast('비디오 정보를 불러오지 못했습니디');
      throw '유튜브 앱(웹) 런치 실패';
    }

    /// 시청기록 업데이트
    /// 가장 최신 시청 기록의 컨텐츠를 선택했을 경우 업데이트 할 필요가 없음. (메소드 종료)
    if (index == 0) return;
    await updateUserWatchHistory(selectedContent);
  }

  /// 유저 시청 기록 추가
  Future<void> updateUserWatchHistory(
    UserWatchHistoryItem selectedContent,
  ) async {
    final requestData = WatchingHistoryRequest(
      userId: _userService.userInfo.value!.id!,
      originId: selectedContent.originId,
      videoId: selectedContent.videoId,
    );

    final response = await _userRepository.addUserWatchHistory(requestData);
    response.fold(
      onSuccess: (_) {
        log('유저 시청기록 추가 성공');
        // 유저 시청 기록 업데이트
        _userService.updateUserWatchHistory();
        notifyListeners();
      },
      onFailure: (e) {
        log('ContentDetailViewModel : $e');
      },
    );
  }

  // 유저 시청 기록 호출
  Future<void> _fetchUserWatchHistory() async {
    await _userService.updateUserWatchHistory();
    watchHistoryList = _userService.userWatchHistory.value;
    notifyListeners();
  }

  // 유저 정보 호출
  Future<void> getUserInfo() async {
    // await _userService.getUserInfo(); // fetch 메소드 실행
    userInfo = _userService.userInfo.value;
  }

  // 큐레이팅 내역 스크린으로 라우팅
  void routeToCurationHistory() {
    Get.toNamed(AppRoutes.curationHistory);
  }

  // 유저 큐레이션 내역 요약 정보 호출
  Future<void> fetchUserCurationSummary() async {
    final userId = _userService.userInfo.value?.id;
    final response = await _userRepository.loadUserCurationSummary(userId!);
    response.fold(
      onSuccess: (data) {
        curationSummary = data;
      },
      onFailure: (e) {
        log('MyPageViewModel $e');
      },
    );
  }

  Future<void> prepare() async {
    loadingState = ViewModelLoadingState.loading;
    await getUserInfo();
    await fetchUserCurationSummary();
    await _fetchUserWatchHistory();
    loadingState = ViewModelLoadingState.done;

    /// 시청 기록 & 유저 프로필 정보의 데이터 변화를
    /// listen 하고 ui를 업데이트 함.
    ///
    // _userService.userInfo.listen((_) {
    //   userInfo.value = _userService.userInfo.value;
    // });
    // _userService.userWatchHistory.listen((_) {
    //   _watchHistoryList.value = _userService.userWatchHistory.value;
    // });
  }

  @override
  Future<void> onInit() async {
    super.onInit();
  }
}
