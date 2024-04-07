import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/base/base_no_param_use_case.dart';
import 'package:soon_sak/domain/model/ad/ad_model.dart';
import 'package:soon_sak/utilities/index.dart';

class LoadAdInfoUseCase extends BaseNoParamUseCase<Result<AdModel>> {
  LoadAdInfoUseCase(this.repository);
  final StaticContentRepository repository;

  @override
  Future<Result<AdModel>> call() => repository.loadAdInfo();
}
