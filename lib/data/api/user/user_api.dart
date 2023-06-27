import 'dart:io';

import 'package:soon_sak/data/api/user/request/preferred_content_request.dart';
import 'package:soon_sak/data/api/user/request/user_onboarding_preferred_request.dart';
import 'package:soon_sak/utilities/index.dart';

abstract class UserApi {
  // 유저 큐레이션 정보 추가
  Future<void> addUserCurationInfo({
    required String curationDocId,
    required String userId,
  });

  // 유저 큐레이션 요약 정보 호출
  Future<UserCurationSummaryResponse> loadUserCurationSummary(
    final String userId,
  );

  // 유저 회원탈퇴
  Future<void> withdrawUser(String userId);

  // 유저의 큐레이션 리스트 호출
  Future<List<CurationContentResponse>> loadUserCurationContentList(
    String userId,
  );

  // 유저 시청 기록 추가
  Future<void> addUserWatchHistory(WatchingHistoryRequest requestInfo);

  // 유저 시청 기록 호출
  Future<List<UserWatchHistoryItemResponse?>> loadUserWatchHistory(
    String userId,
  );

  // 닉네임 중복 여부 확인
  Future<bool> checkDuplicateDisplayName(String inputName);

  // 프로필 정보 업데이트
  Future<void> updateUserProfile(UserProfileRequest requestInfo);

  // 프로필 사진 정보 저장 (Storage)
  Future<String> uploadUserProfileImgAndReturnUrl({
    required String userId,
    required File file,
  });

  // 유저 선호 콘텐츠 & 채널 필드 업데이트 (온보딩)
  Future<void> updateUserPreferences(
      UserOnboardingPreferredRequest req, String userId);

  // 유저 선호 콘텐츠 & 채널 필드 존재 여부
  Future<bool> checkIfUserHasPreferencesData(String userId);

  // 유저 선호 채널 값 업데이트
  Future<void> updateUserChannelPreference(
      {required String userId, required String channelId});

  // 유저 선호 장르 값 업데이트
  Future<void> updateUserGenrePreference(
      {required String userId, required List<PreferredRequestContent> genres});
}
