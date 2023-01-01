part of '../content_detail_view_model.dart';

/** Created By Ximya - 2023.1.1
 *  컨텐츠 비디오 섹션 뷰
 *  [ContentVideoFormat]에 따라 리소스를 다르게 분리함.
 * */

extension ContentDetailVideoViewModel on ContentDetailViewModel {
  // 컨텐츠 비디오 포맷
  ContentVideoFormat? get contentVideoFormat =>
      contentVideos.value?.contentVideoFormat;

  bool get isVideoContentLoaded {
    if (contentType.isMovie) {
      return contentVideos.value?.isDetailInfoLoaded.value ?? false;
    } else {
      if (contentVideos.value?.contentVideoFormat ==
          ContentVideoFormat.multipleTv) {
        return contentVideos.value?.isSeasonInfoLoaded.value ?? false;
      } else {
        return contentVideos.value?.isDetailInfoLoaded.value ?? false;
      }
    }

    // if (contentVideos.value.hasData) {
    //   if (contentVideos.value!.isDetailInfoLoaded.value) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // } else {
    //   return false;
    // }
  }

  /* [ContentVideoFormat] - single 타입 리소스 (movie, tv)*/
  // 유튜브 영상 썸네일 이미지
  String? get singleVideoThumbnailUrl =>
      passedArgument.thumbnailUrl ??
      contentVideos.value?.singleTypeVideo.detailInfo?.videoThumbnailUrl;

  // 유튜브 컨텐츠 조회수
  String? get singleVideoViewCount => Formatter.formatViewAndLikeCount(
        contentVideos.value?.singleTypeVideo.detailInfo?.viewCount,
        isViewCount: true,
      );

  // 유튜브 컨텐츠 좋아요 수
  String? get singleLikesCount => Formatter.formatViewAndLikeCount(
      contentVideos.value?.singleTypeVideo.detailInfo?.likeCount);

  // 유튜브 컨텐츠 업로드 일자
  String? get singleUploadDate => Formatter.getDateDifferenceFromNow(
      contentVideos.value?.singleTypeVideo.detailInfo?.uploadDate);

  /* [ContentVideoFormat] - multiple 타입 리소스  */
  List<String>? get multipleVideoThumbnailUrls =>
      contentVideos.value?.multipleTypeVideos
          .map((e) => e.detailInfo!.videoThumbnailUrl)
          .toList();

  List<YoutubeVideo>? get multipleVideoInfo =>
      contentVideos.value?.multipleTypeVideos;
}
