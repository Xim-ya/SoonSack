
import 'package:uppercut_fantube/utilities/index.dart';

class ExploreContentIdInfo {
  final int contentId;
  final String videoId;
  final ContentType contentType;

  ExploreContentIdInfo({required this.contentId,
    required this.videoId,
    required this.contentType});


  factory ExploreContentIdInfo.fromJson(Map<String, dynamic> json) {
    return ExploreContentIdInfo(
        contentId: SplittedIdAndType.fromOriginId(json['contentId']).id,
        videoId: json['videoId'],
        contentType: SplittedIdAndType.fromOriginId(json['contentId']).type);
  }
}

