import 'package:soon_sak/data/api/staticContent/response/ad_info_response.dart';

class AdModel {
  final String imgUrl;
  final String impactUrl;

  AdModel({
    required this.imgUrl,
    required this.impactUrl,
  });

  factory AdModel.fromResponse(AdInfoResponse response) =>
      AdModel(imgUrl: response.imgUrl, impactUrl: response.impactUrl);
}
