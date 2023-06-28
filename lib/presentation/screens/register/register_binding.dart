import 'package:soon_sak/app/di/binding.dart';
import 'package:soon_sak/domain/useCase/register/request_content_registration_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    super.dependencies();

    locator.registerFactory(
      () => RegisterViewModel(
        userService: locator<UserService>(),
        searchValidateUrlUseCase: locator<SearchValidateUrlUseCase>(),
        requestContentRegistrationUseCase:
            locator<RequestContentRegistrationUseCase>(),
        curationViewModel: locator<CurationViewModel>(),
        myPageViewModel: locator<MyPageViewModel>(),
        newSearchedPagedContentUseCase: locator<SearchedPagedContentUseCase>(),
        contentType: arg1,
      ),
    );

    locator.registerFactory(
      () => RequestContentRegistrationUseCase(
        contentRepository: locator<ContentRepository>(),
        userRepository: locator<UserRepository>(),
      ),
    );

    locator.registerFactory<SearchValidateUrlUseCase>(
      () => SearchValidateUrlImpl(),
    );

    locator.registerLazySingleton(() =>
        SearchedPagedContentUseCase(tmdbRepository: locator<TmdbRepository>()));
  }

  @override
  void unRegisterDependencies() {
    super.unRegisterDependencies();
    locator.unregister<RegisterViewModel>();
    locator.unregister<RequestContentRegistrationUseCase>();
    locator.unregister<SearchValidateUrlUseCase>();
    locator.unregister<SearchedPagedContentUseCase>();
  }
}
