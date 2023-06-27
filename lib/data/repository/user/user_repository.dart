import 'dart:io';

import 'package:soon_sak/data/api/user/request/preferred_content_request.dart';
import 'package:soon_sak/data/api/user/request/user_onboarding_preferred_request.dart';
import 'package:soon_sak/data/local/box/user/user_box.dart';
import 'package:soon_sak/utilities/index.dart';

abstract class UserRepository {
  // 유저 큐레이션 정보 추가
  Future<Result<void>> addUserCurationInfo({
    required String qurationDocId,
    required String userId,
  });

  // 유저 큐레이션 요약 정보 호출
  Future<Result<UserCurationSummary>> loadUserCurationSummary(
    final String userId,
  );

  // 유저 회원탈퇴
  Future<Result<void>> withdrawUser(String userId);

  // 유저의 큐레이션 리스트 호출
  Future<Result<List<CurationContent>>> loadUserCurationContentList(
    String userId,
  );

  // 유저 시청 기록 추가
  Future<Result<void>> addUserWatchHistory(WatchingHistoryRequest requestInfo);

  // 유저 시청 기록 데이터 호출
  Future<Result<List<UserWatchHistoryItem>>> loadUserWatchHistory(
    String userId,
  );

  // 닉네임 중복 여부 확인
  Future<Result<bool>> checkDuplicateDisplayName(String inputName);

  // 프로필 정보 업데이트
  Future<Result<void>> updateUserProfile(UserProfileRequest requestInfo);

  // 프로필 사진 정보 저장 (Storage)
  Future<Result<String>> uploadUserProfileImgAndReturnUrl({
    required String userId,
    required File file,
  });

  // 유저 선호 콘텐츠 & 채널 필드 업데이트 (온보딩)
  Future<Result<void>> updateUserPreferences(
      UserOnboardingPreferredRequest req);

  // 유저 온보딩 진행 여부
  Result<bool> isOnboardingProgressDone();

  // 유저 정보 로컬 저장
  Result<void> saveUserLocalData(String userId);

  // 유저 로컬 데이터 호출
  Result<UserBox?> getUserLocalData();

  // 유저 온보딩 진행 여부값을 판별하는데 사용 (서버에서 데이터를 가져옴)
  Future<Result<bool>> checkIfUserHasPreferencesData(String userId);

  // 유저 온보딩 state 변경
  Result<void> changeUserOnboardingState(String userId);

  // 유저 로컬 데이터 삭제
  Result<void> clearUserLocalData();

  // 유저 선호 채널 값 업데이트
  Future<Result<void>> updateUserChannelPreference(String channelId);

  // 유저 선호 장르 값 업데이트
  Future<Result<void>> updateUserGenrePreference(List<PreferredRequestContent> genres);
}
