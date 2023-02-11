import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uppercut_fantube/data/dto/staticContent/response/category_content_collection_response.dart';
import 'package:uppercut_fantube/data/dto/staticContent/response/content_key_response.dart';
import 'package:uppercut_fantube/utilities/index.dart';

part 'static_content_api.g.dart';

@RestApi(
    baseUrl:
        'https://soonsak-15350-default-rtdb.asia-southeast1.firebasedatabase.app')
abstract class StaticContentApi {
  factory StaticContentApi(Dio dio) = _StaticContentApi;

  @GET('/contentKey.json')
  Future<ContentKeyResponse> loadStaticContentKeys();

  @GET('/banner.json')
  Future<BannerResponse> loadBannerContent();

  @GET('/topTenContent.json')
  Future<TopTenContentResponse> loadTopTenContent();

  @GET('/categoryContent.json')
  Future<CategoryContentCollectionResponse> loadCategoryContentCollection();
}
