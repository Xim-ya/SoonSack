import 'package:soon_sak/utilities/index.dart';

part 'ad_info_response.g.dart';

@JsonSerializable(createToJson: false)
class AdInfoResponse {
  @JsonKey(name: 'imgUrl')
  String imgUrl;

  @JsonKey(name: 'impactUrl')
  String impactUrl;

  AdInfoResponse(this.imgUrl, this.impactUrl);

  factory AdInfoResponse.fromJson(Map<String, dynamic> json) {
    return _$AdInfoResponseFromJson(json);
  }
}
