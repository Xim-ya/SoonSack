import 'package:soon_sak/app/di/custom_binding.dart';
import 'package:soon_sak/data/repository/channel/channel_respoitory.dart';
import 'package:soon_sak/domain/useCase/channel/load_paged_channel_contents_use_case.dart';
import 'package:soon_sak/presentation/screens/channel/channel_detail_view_model.dart';
import 'package:soon_sak/utilities/index.dart';

class ChannelDetailBinding extends CustomBindings {
  @override
  void dependencies() {
    super.dependencies();
    locator.registerFactory(
      () => ChannelDetailViewModel(
        argument: argument,
        loadChannelContentsUseCase: locator<LoadPagedChannelContentsUseCase>(),
      ),
    );

    locator.registerFactory(
      () => LoadPagedChannelContentsUseCase(
        locator<ChannelRepository>(),
      ),
    );
  }

  @override
  void unRegisterDependencies() {
    super.unRegisterDependencies();
    locator.unregister<ChannelDetailViewModel>();
    locator.unregister<LoadPagedChannelContentsUseCase>();
  }
}