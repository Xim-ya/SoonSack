import 'package:soon_sak/utilities/index.dart';

abstract class ContentApi {

  // 모든 컨텐츠 id 리스트 호출
  Future<List<String>> loadTotalContentIdList();

  // 주어진 ids에 속한 컨텐츠 리스트 호출
  Future<List<BasicContentInfoResponse>> loadContainingIdsContents(List<String> ids);

  // 컨텐츠 비디오 정보 호출
  Future<List<VideoResponse>> loadVideoInfo(String id);


}