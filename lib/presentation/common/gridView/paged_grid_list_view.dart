import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:soon_sak/app/config/app_insets.dart';
import 'package:soon_sak/app/config/app_space_config.dart';
import 'package:soon_sak/app/config/color_config.dart';
import 'package:soon_sak/app/config/font_config.dart';
import 'package:soon_sak/presentation/screens/home/localWidget/category_content_section_skeleton_view.dart';

class PagedGridListView<T> extends StatelessWidget {
  const PagedGridListView({
    Key? key,
    required this.pagingController,
    required this.itemBuilder,
  }) : super(key: key);

  final PagingController<int, T> pagingController;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    return PagedSliverGrid<int, T>(
      pagingController: pagingController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 24,
        crossAxisSpacing: 9,
        childAspectRatio: 109 / 200,
      ),
      builderDelegate: PagedChildBuilderDelegate<T>(
        // animateTransitions: true,

        /* 다음 페이지 리스트 불러올 때 로딩 Indicator */
        newPageProgressIndicatorBuilder: (context) => const Center(
          child: CircularProgressIndicator(
            strokeWidth: 3.6,
            color: AppColor.gray06,
          ),
        ),

        /* 에러 문구 */
        firstPageErrorIndicatorBuilder: (context) {
          return Expanded(
            child: Center(
              child: Text(
                '콘텐츠를 불러오는데 실패했어요',
                style: AppTextStyle.headline3,
                textAlign: TextAlign.center,
              ),
            ),
          );
        },

        /* 로딩 인디케이터 */
        firstPageProgressIndicatorBuilder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.gray06,
            ),
          );
        },
        /* 검색 결과*/
        itemBuilder: itemBuilder,
      ),
    );
  }
}
