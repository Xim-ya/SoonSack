import 'package:provider/provider.dart';
import 'package:soon_sak/presentation/base/base_view.dart';
import 'package:soon_sak/presentation/screens/contentDetail/content_detail_scaffold.dart';
import 'package:soon_sak/presentation/common/skeleton_box.dart';
import 'package:soon_sak/utilities/index.dart';

class ContentDetailScreen extends BaseView<ContentDetailViewModel> {
  const ContentDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentDetailScaffold(
      header: const _Header(),
      rateAndGenreView: const _RateAndGenreView(),
      tabs: _buildTab(),
      tabViews: _buildTabBarViews(),
      headerBgImg: const _HeaderBgImg(),
    );
  }

  // 탭뷰
  List<Widget> _buildTabBarViews() => [
        const MainContentTabView(),
        const ContentDetailInfoTabView(),
      ];

  // 탭바
  List<Tab> _buildTab() {
    return const [
      Tab(text: '컨텐츠', height: 42),
      Tab(text: '정보', height: 42),
    ];
  }

  // Sliver레이아웃에서 Tab이 고정되기 위해서 [Sizse.zero]인 Appbar가 필요
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.zero,
      child: AppBar(
        backgroundColor: Colors.black,
      ),
    );
  }
}

// 평점 & 장르 뷰
class _RateAndGenreView extends BaseView<ContentDetailViewModel> {
  const _RateAndGenreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          'RATE',
          style: AppTextStyle.extraFont.copyWith(
            color: const Color(0xFFE6E6E6).withOpacity(0.66),
          ),
        ),
        // Text(
        //   vmS<String>(context, (vm) => vm.rate ?? '-'),
        //   style: AppTextStyle.alert2.copyWith(
        //     color: const Color(0xFFA8A8A8).withOpacity(0.40),
        //   ),
        // ),
        AppSpace.size4,
        Text(
          'GENRE',
          style: AppTextStyle.extraFont.copyWith(
            color: const Color(0xFFE6E6E6).withOpacity(0.66),
          ),
        ),
        Text(
          vmS<String>(context, (vm) => vm.genre ?? '-'),
          style: AppTextStyle.alert2.copyWith(
            color: const Color(0xFFA8A8A8).withOpacity(0.40),
          ),
        ),
      ],
    );
  }
}

/// 헤더뷰
class _Header extends BaseView<ContentDetailViewModel> {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ContentDetailViewModel>(
        builder: (context, vm, _) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 480,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // 제목 & 날짜
                  Row(
                    children: <Widget>[
                      vmS(
                        context,
                        (vm) => vm.headerTitle.hasData
                            ? Text(vm.headerTitle!,
                                style: AppTextStyle.headline2)
                            : const ShimmerSkeletonBox(
                                height: 28,
                                width: 40,
                              ),
                      ),
                      AppSpace.size6,
                      vmS(
                          context,
                          (vm) => vm.releaseDate.hasData
                              ? Text(
                                  vm.releaseDate!,
                                  style: AppTextStyle.alert2,
                                )
                              : const ShimmerSkeletonBox(
                                  height: 10,
                                  width: 44,
                                )),
                    ],
                  ),
                  AppSpace.size8,
                  // 컨텐츠 설명 - (유튜브 영상 제목)
                  vmS(
                    context,
                    (vm) => vm.contentVideoTitle.hasData
                        ? Text(
                            vm.contentVideoTitle!,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.headline3
                                .copyWith(color: AppColor.lightGrey),
                          )
                        : Column(
                            children: const [
                              ShimmerSkeletonBox(
                                height: 22,
                                width: double.infinity,
                              )
                            ],
                          ),
                  ),

                  AppSpace.size24,
                ],
              ),
            ));
  }
}

class _HeaderBgImg extends BaseView<ContentDetailViewModel> {
  const _HeaderBgImg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ContentDetailViewModel, String?>(
      selector: (context, vm) => vm.headerBackdropImg,
      builder: (context, headerBackdropImg, _) {
        return headerBackdropImg.hasData
            ? CachedNetworkImage(
                memCacheWidth: (SizeConfig.to.screenWidth * 3).toInt(),
                width: SizeConfig.to.screenWidth,
                fit: BoxFit.fitWidth,
                imageUrl: vmS<String>(
                    context, (vm) => headerBackdropImg!.prefixTmdbImgPath),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            : const SizedBox();
      },
    );
  }
}
