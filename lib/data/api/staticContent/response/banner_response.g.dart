// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerResponse _$BannerResponseFromJson(Map<String, dynamic> json) =>
    BannerResponse(
      json['key'] as String,
      (json['items'] as List<dynamic>)
          .map((e) => BannerItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

BannerItemResponse _$BannerItemResponseFromJson(Map<String, dynamic> json) =>
    BannerItemResponse(
      id: json['id'] as String,
      videoId: json['videoId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imgUrl: json['imgUrl'] as String,
      backdropImgUrl: json['backdropImgUrl'] as String,
    );