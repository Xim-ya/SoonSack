import 'package:soon_sak/domain/model/video/content_video_model.dart';
import 'package:soon_sak/utilities/index.dart';

class ContentRepositoryImpl implements ContentRepository {
  ContentRepositoryImpl(this._contentDataSource);

  final ContentDataSource _contentDataSource;

  @override
  Future<Result<List<ContentIdInfoItem>>> loadContentIdInfoList() async {
    try {
      final response = await _contentDataSource.loadTotalContentIdList();
      return Result.success(
        response.map(ContentIdInfoItem.fromOriginId).toList(),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }




  @override
  Future<Result<String>> requestContentRegistration(
    ContentRegistrationRequest requestData,
  ) async {
    try {
      final response =
          await _contentDataSource.requestContentRegistration(requestData);
      return Result.success(response);
    } on Exception {
      return Result.failure(ContentException.qurationRequestFailed());
    }
  }

  @override
  Future<Result<List<CurationContent>>> loadInProgressQurationList() async {
    try {
      final response = await _contentDataSource.loadInProgressQurationList();
      return Result.success(
        response.map(CurationContent.fromResponse).toList(),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<UserModel>> loadCuratorInfo(String contentId) async {
    try {
      final response = await _contentDataSource.loadCuratorInfo(contentId);
      return Result.success(UserModel.fromCurationRes(response));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<ExploreContent>>> loadExploreContents(
    List<String> ids,
  ) async {
    try {
      final response = await _contentDataSource.loadExploreContents(ids);
      return Result.success(
        response.map(ExploreContent.fromResponse).toList(),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> requestContent(ContentRequest requestInfo) async {
    try {
      final response = await _contentDataSource.requestContent(requestInfo);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }


}
