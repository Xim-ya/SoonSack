import 'dart:developer';
import 'package:soon_sak/utilities/index.dart';

class CurationHistoryViewModel extends BaseViewModel
    with GetSingleTickerProviderStateMixin {
  CurationHistoryViewModel(this._userRepository, this._userService);

  /* Data Modules */
  final UserService _userService;

  /* Variables */
  final List<CurationContent> userCurationList = [];

  // 진행중 상태 큐레이션 리스트
  List<CurationContent> get inProgressCuration {
    return userCurationList
        .where((e) => e.status == CurationStatus.inProgress)
        .toList();
  }

  // 등록 완료 상태 큐레이션 리스트
  List<CurationContent> get completedCurationList {
    return userCurationList
        .where((e) => e.status == CurationStatus.completed)
        .toList();
  }

  // 보류 상태 큐레이션 리스트
  List<CurationContent> get onHoldCurationList {
    return userCurationList
        .where((e) => e.status == CurationStatus.onHold)
        .toList();
  }

  /* DataModules */
  final UserRepository _userRepository;

  /* Controller */
  late final TabController tabController;

  /* Intent */
  Future<void> _fetchUserCurationContents() async {
    final userId = _userService.userInfo.value!.id;
    final response = await _userRepository.loadUserCurationContentList(userId!);
    response.fold(
      onSuccess: (data) {
        userCurationList.addAll(data);
        loading(false);
        update();
      },
      onFailure: (e) {
        log('CurationHistoryViewModel : $e');
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    loading(true);
    tabController = TabController(length: 3, vsync: this);

    _fetchUserCurationContents();
  }

}
