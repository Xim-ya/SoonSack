import 'package:soon_sak/utilities/index.dart';

class TmdbDataSourceImpl implements TmdbDataSource {
  TmdbDataSourceImpl(this._api);

  final TmdbApi _api;

// tmdb tv 컨텐츠 상세 정보
  @override
  Future<TmdbTvDetailResponse> loadTmdbTvDetailResponse(int tvId) async =>
      _api.loadTmdbMovieDetailResponse(tvId);

// tmdb tv 컨텐츠 크레딧 정보
  @override
  Future<TmdbContentCreditResponse> loadTmdbTvCastInfoResponse(
          int tvId) async =>
      _api.loadTvCreditInfo(tvId);

// tmdb tv 이미지 리스트
  @override
  Future<TmdbImagesResponse> loadTmdbTvIContentImages(int tvId) async =>
      _api.loadTvImages(tvId);

  @override
  Future<TmdbMovieDetailResponse> loadTmdbMovieDetailResponse(
          int movieId) async =>
      _api.loadTmdbMovieDetailInfoResponse(movieId);


  @override
  Future<TmdbContentCreditResponse> loadTmdbMovieCreditInfoResponse(
          int movieId) async =>
      _api.loadMovieCreditInfo(movieId);

  @override
  Future<TmdbImagesResponse> loadTmdbMovieIContentImages(int movieId) async =>
      _api.loadMovieImages(movieId);


  @override
  Future<TmdbTvContentListWrappedResponse> loadSearchedTvContentList(
      {required String query, required int page}) async =>
      _api.loadSearchedTvContentList(page, query);

  @override
  Future<TmdbMovieContentListWrappedResponse> loadSearchedMovieContentList(
      {required String query, required int page}) async =>
      _api.loadSearchedMovieContentList(page, query);
}
