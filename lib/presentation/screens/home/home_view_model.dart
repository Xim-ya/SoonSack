import 'dart:developer';
import 'package:soon_sak/utilities/index.dart';
import 'package:http/http.dart' as http;

part 'home_view_model.part.dart';

class HomeViewModel extends BaseViewModel with FirestoreHelper {
  /// 임시
  final ContentDataSource _dataSource;

  HomeViewModel(
    this._loadCachedCategoryContentCollectionUseCase,
    this._loadCachedTopTenContentsUseCase,
    this._loadBannerContentUseCase,
    this._dataSource,
  );

  /* [Variables] */

  /// Data
  final Rxn<BannerModel> _bannerContent = Rxn();
  final Rxn<TopTenContentsModel> _topTenContents = Rxn();
  final Rxn<CategoryContentCollection> _categoryContentCollection = Rxn();

  // final Rxn<List<CategoryBaseContentList>> contentListWithCategories =
  //     Rxn(); // 카테고리 및 카테고리 컨텐츠

  /// State
  late double scrollOffset = 0;
  final RxBool showAppbarBackground = true.obs;
  RxBool showBlurAtAppBar = false.obs;
  RxInt topExposedContentSliderIndex = 0.obs; // 상단 노출 컨텐츠 슬라이더의 현재 인덱스

  /// Size
  final double appBarHeight = SizeConfig.to.statusBarHeight + 56;

  ///  Controllers
  late ScrollController scrollController;
  late CarouselController carouselController;

  /* [UseCase] */
  final LoadCachedBannerContentUseCase _loadBannerContentUseCase;
  final LoadCachedTopTenContentsUseCase _loadCachedTopTenContentsUseCase;
  final LoadCachedCategoryContentCollectionUseCase
      _loadCachedCategoryContentCollectionUseCase;

  /* [Intent] */
  void onBannerSliderSwiped(int index) {
    topExposedContentSliderIndex.value = index;
  }

  // 컨텐츠 상세 화면으로 이동
  void routeToContentDetail(ContentArgumentFormat routingArgument) {
    Get.toNamed(AppRoutes.contentDetail, arguments: routingArgument);
  }

  // 카테고리 컨텐츠 collection 정보 호출
  Future<void> _fetchCategoryContentCollection() async {
    final response = await _loadCachedCategoryContentCollectionUseCase.call();
    response.fold(
      onSuccess: (data) {
        _categoryContentCollection.value = data;
      },
      onFailure: (e) {
        log('HomeViewModel > $e');
      },
    );
  }

  /// UI Intent Method
  // AppBar Blur효과 avtivate 여부
  void turnOnBlurInAppBar() {
    // Status Bar Height 보다 offest이 작을 땐 Blur 처리 X
    if (scrollOffset <= SizeConfig.to.statusBarHeight) {
      showBlurAtAppBar(false);
      return;
    } else {
      /** 중복 할당을 방지하기 위해. 조건 두가지를 추가.
       * [scrollController.position.userScrollDirection] 유저가 아래로 스크롤하고
       * [showBlurAtAppBar.isTrue] blur값이 true로 선언되어 있다면 값을 변경.
       * */
      if (scrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
          showBlurAtAppBar.isTrue) {
        showBlurAtAppBar(false);
        return;
      } else if (scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          showBlurAtAppBar.isFalse) {
        showBlurAtAppBar(true);
        return;
      }
    }
  }

  // 검색 스크린으로 이동
  void routeToSearch() {
    Get.toNamed(AppRoutes.search);
  }

  // 카테고리 & 해당 카테고리 컨텐츠 리스트 호출
  Future<void> _fetchContentListOfCategory() async {
    final responseResult =
        await ContentRepository.to.loadContentListWithCategory();
    responseResult.fold(onSuccess: (data) {
      // contentListWithCategories.value = data;
    }, onFailure: (e) {
      AlertWidget.toast('카테고리 정보를 불러들이는데 실패하였습니다');
      log(e.toString());
    });
  }

  void launchAnotherApp() async {
    if (!await launchUrl(
        Uri.parse('https://www.youtube.com/watch?v=zhdbtAqne_I&t=1162s'),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch ';
    }
  }




  Future<void> aim() async {
    try {
      final aim = await YoutubeMetaData.yt.videos.get('N16uIvWozVk');
      print("just PAssted");
    } on Exception catch (e) {
      print("ARANG Exception Activate${e}");
    }
  }

  Future<bool?> validateResponse() async {
    const dynamic url = 'https://www.youtube.com/watch?v=N16uIvWozVk';
    var response =
        await http.get(url is String ? Uri.parse(url) : url, headers: {});

    // final response = await http
    //     .head(Uri.parse('https://www.youtube.com/watch?v=N16uIvWozVk'));

    var request = response.request!;

    if (response.statusCode == 200) {
      print("FINALLY RETURNES TRUE");
      return true;
    }

    if (request.url.host.endsWith('.google.com') &&
        request.url.path.startsWith('/sorry/')) {
      return false;
    }

    if (response.statusCode >= 500) {
      return false;
    }

    if (response.statusCode == 429) {
      return false;
    }

    if (response.statusCode >= 400) {
      return false;
    }
  }

  Future<void> testResponseResult() async {
    // print(_bannerContent.key);
  }

  Future<void> _fetchTopTenContents() async {
    final response = await _loadCachedTopTenContentsUseCase.call();
    response.fold(onSuccess: (data) {
      _topTenContents.value = data;
      update();
    }, onFailure: (e) {
      log('HomeViewModel > $e');
    });
  }

  Future<void> _fetchBannerContents() async {
    final response = await _loadBannerContentUseCase.call();
    response.fold(
      onSuccess: (data) {
        _bannerContent.value = data;
        update();
      },
      onFailure: (e) {
        log('HomeViewModel > $e');
      },
    );
  }

  Future<void> document() async {
    final documentReference = await getFirstSubCollectionDoc('user',
        docId: 'zyN1qU1gAkSdtpFCuDGS0GBTO9m2', subCollectionName: 'curation');
    DocumentReference<Map<String, dynamic>> ref = documentReference.get('temp');
    final data = await ref.get();
    print('파이버에스 테스트 결과 ${data.get('title')}');
  }

  Future<void> firebaseStoreTest() async {
    final documentSnapshots = await getSubCollectionDocs('user',
        docId: 'zyN1qU1gAkSdtpFCuDGS0GBTO9m2', subCollectionName: 'curation');

    DocumentReference<Map<String, dynamic>> ref =
        documentSnapshots[1].get('temp');

    final data = await ref.get();

    print(data.get('title'));
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    scrollController = ScrollController();
    scrollController.addListener(() {
      scrollOffset = scrollController.offset;
      turnOnBlurInAppBar();
    });


    carouselController = CarouselController();

    await _fetchBannerContents();
    await _fetchTopTenContents();
    await _fetchCategoryContentCollection();

    // _fetchContentListOfCategory();


    update();
    // firebaseStoreTest();

    // loadBannerContents();
    // aim();
  }
}
