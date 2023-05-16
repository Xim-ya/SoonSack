import 'package:soon_sak/data/api/channel/request/channe_contents_request.dart';
import 'package:soon_sak/data/dataSource/channel/channel_data_source.dart';
import 'package:soon_sak/data/repository/channel/channel_respoitory.dart';
import 'package:soon_sak/domain/model/channel/channel_content_list.dart';
import 'package:soon_sak/domain/model/channel/channel_model.dart';
import 'package:soon_sak/domain/model/content/home/new_content_poster_shell.dart';
import 'package:soon_sak/utilities/result.dart';

class ChannelRepositoryImpl implements ChannelRepository {
  ChannelRepositoryImpl(this._dataSource);

  final ChannelDataSource _dataSource;

  @override
  Future<Result<List<ChannelModel>>> loadChannelsBaseOnSubscribers() async {
    try {
      final response = await _dataSource.loadChannelsBaseOnSubscribers();
      return Result.success(
          response.map((e) => ChannelModel.fromResponse(e)).toList());
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<ChannelContentList>> loadChannelContents(
      ChannelContentsRequest request) async {
    try {
      final response = await _dataSource.loadChannelContents(request);
      if (response.isEmpty) {
        return Result.failure(Exception('콘텐츠 데이터를 불러오는데 실패했습니다'));
      }
      return Result.success(ChannelContentList(
          contents: response
              .map((e) => NewContentPosterShell.fromChannelContents(e))
              .toList(),
          lastDocument: response.last.originDoc));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
