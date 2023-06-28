import 'dart:io';

import 'package:soon_sak/data/api/user/request/preferred_content_request.dart';
import 'package:soon_sak/data/api/user/request/user_onboarding_preferred_request.dart';
import 'package:soon_sak/data/mixin/fire_storage_helper_mixin.dart';
import 'package:soon_sak/utilities/index.dart';

class UserApiImpl with FirestoreHelper, FireStorageHelper implements UserApi {
  @override
  Future<void> addUserCurationInfo({
    required String curationDocId,
    required String userId,
  }) async {
    final Map<String, dynamic> curationList = {
      'curationRef': db.collection('curation').doc(curationDocId)
    };

    // 초기 값
    final Map<String, dynamic> curationSummary = {
      'completedCount': 0,
      'inProgressCount': 1,
      'onHoldCount': 0,
    };

    return storeAndUpdateDocumentAndSubCollection(
      'user',
      docId: userId,
      data: curationList,
      firstSubCollectionName: 'curationList',
      firstSubCollectionData: curationList,
      firstSubCollectionDocId: curationDocId,
      secondSubCollectionName: 'curationSummary',
      secondSubCollectionData: curationSummary,
      secondSubCollectionFieldName: 'inProgressCount',
    );
  }

  @override
  Future<UserCurationSummaryResponse> loadUserCurationSummary(
    String userId,
  ) async {
    final snapshot = await getSingleSubCollectionDoc(
      'user',
      docId: userId,
      subCollectionName: 'curationSummary',
    );

    final doc = snapshot.docs;

    if (doc.isNotEmpty) {
      return UserCurationSummaryResponse.fromDoc(doc.single);
    } else {
      /// curation 내역이 없으면 초기값 전달
      return UserCurationSummaryResponse(
        completedCount: 0,
        inProgressCount: 0,
        onHoldCount: 0,
      );
    }
  }

  @override
  Future<List<CurationContentResponse>> loadUserCurationContentList(
    String userId,
  ) async {
    final docs = await getSubCollectionDocs(
      'user',
      docId: userId,
      subCollectionName: 'curationList',
    );

    final resultList = docs.map((e) async {
      final DocumentReference<Map<String, dynamic>> ref = e.get('curationRef');
      final doc = await ref.get();
      return CurationContentResponse.fromUserResponseDoc(doc);
    }).toList();

    return Future.wait(resultList);
  }

  @override
  Future<void> addUserWatchHistory(WatchingHistoryRequest requestInfo) async {
    final contentRef = db.collection('content').doc(requestInfo.originId);

    final data = requestInfo.toMap(
      contentRef: contentRef,
    );

    await cudSubCollectionDocumentWithLimit(
      'user',
      docId: requestInfo.userId,
      subCollectionName: 'watchHistory',
      subCollectionDocId: requestInfo.originId,
      firstMutableFieldName: 'watchedDate',
      secondMutableFieldName: 'videoId',
      data: data,
    );
  }

  @override
  Future<List<UserWatchHistoryItemResponse?>> loadUserWatchHistory(
    String userId,
  ) async {
    final docs = await getSubCollectionDocsByOrder(
      'user',
      docId: userId,
      subCollectionName: 'watchHistory',
      orderFieldName: 'watchedDate',
    );

    final resultList = docs.map((e) async {
      /// 시청 기록 데이터가 유효할 경우에만 객체를 리턴
      /// 반대의 경우 null을 리턴함
      try {
        final DocumentReference<Map<String, dynamic>> contentRef =
            e.get('contentRef');
        final contentDoc = await contentRef.get();
        return UserWatchHistoryItemResponse.fromResponseDoc(
          contentDoc: contentDoc,
          doc: e,
        );
      } catch (e) {
        return null;
      }
    }).toList();

    return Future.wait(resultList);
  }

  @override
  Future<bool> checkDuplicateDisplayName(String inputName) async {
    final isContainedFieldValue = await checkIfItContainField(
      'user',
      fieldName: 'displayName',
      data: inputName,
    );
    return isContainedFieldValue;
  }

  @override
  Future<void> updateUserProfile(UserProfileRequest requestInfo) async {
    await updateDocumentFields(
      'user',
      docId: requestInfo.userId,
      firstFieldName: 'displayName',
      firstFieldData: requestInfo.displayName,
      secondFieldName: 'photoUrl',
      secondFieldData: requestInfo.photoImgUrl,
    );
  }

  @override
  Future<String> uploadUserProfileImgAndReturnUrl({
    required String userId,
    required File file,
  }) async {
    final downLoadUrl = await storeFileAndReturnDownloadUrl(
      'profileImg',
      fileId: userId,
      file: file,
    );
    return downLoadUrl;
  }

  /// 실제 AUTH 데이터를 삭제하진 않고
  /// User document 이름을 아래와 같이 변경함
  /// ex) WITHDRAW-userId
  @override
  Future<void> withdrawUser(String userId) async {
    await changeDocId('user', docId: userId);
  }

  @override
  Future<void> updateUserPreferences(
      UserOnboardingPreferredRequest req, String userId) async {
    //  콘텐츠 장르 취향 정보 저장
    for (var content in req.contents) {
      final Map<String, dynamic> newData = {
        'count': content.count,
        'name': content.genreName,
        'id': content.genreId,
      };

      await cudSubCollectionDocumentAndIncreaseIntFields(
        'user',
        docId: userId,
        subCollectionName: 'favoriteGenres',
        subCollectionDocId: content.genreId.toString(),
        fieldValue: content.count,
        fieldName: 'count',
        data: newData,
      );
    }

    // 채널 선호 정보 저장
    for (var channel in req.channels) {
      final Map<String, dynamic> newData = {
        'count': 4,
      };

      await cudSubCollectionDocumentAndIncreaseIntFields(
        'user',
        docId: userId,
        subCollectionName: 'favoriteChannels',
        subCollectionDocId: channel.channelId,
        fieldValue: 4,
        fieldName: 'count',
        data: newData,
      );
    }
  }

  @override
  Future<bool> checkIfUserHasPreferencesData(String userId) async {
    final result = checkSubCollectionExist(
      'user',
      docId: userId,
      subCollectionName: 'favoriteGenres',
    );

    return result;
  }

  @override
  Future<void> updateUserChannelPreference(
      {required String userId, required String channelId}) async {
    final Map<String, dynamic> newData = {
      'count': 1,
    };

    await cudSubCollectionDocumentAndIncreaseIntFields(
      'user',
      docId: userId,
      subCollectionName: 'favoriteChannels',
      subCollectionDocId: channelId,
      fieldValue: 4,
      fieldName: 'count',
      data: newData,
    );
  }

  @override
  Future<void> updateUserGenrePreference(
      {required String userId,
      required List<PreferredRequestContent> genres}) async {
    for (var genre in genres) {
      final Map<String, dynamic> newData = {
        'count': 1,
        'name': genre.genreName,
        'id': genre.genreId,
      };

      await cudSubCollectionDocumentAndIncreaseIntFields(
        'user',
        docId: userId,
        subCollectionName: 'favoriteGenres',
        subCollectionDocId: genre.genreId.toString(),
        fieldValue: genre.count,
        fieldName: 'count',
        data: newData,
      );
    }
  }
}
