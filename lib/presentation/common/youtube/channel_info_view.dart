import 'package:soon_sak/utilities/index.dart';

/* Created By Ximya - 2022.12.30
*  채널 프로필 이미지 & 채널명 & 구독자 수
*  위 정보를 구성되어 있는 뷰
*  기본적인 스켈레톤 처리도 진행함
* */

class ChannelInfoView extends StatelessWidget {
  const ChannelInfoView({
    Key? key,
    this.imgSize = 48,
    this.nameFontSize,
    this.subscriberFontSize,
    this.subscriberCount,
    this.nameTextWidth,
    required this.imgUrl,
    required this.name,
  }) : super(key: key);

  final String? imgUrl;
  final String? name;
  final int? subscriberCount;
  final double? nameFontSize;
  final double? subscriberFontSize;
  final double imgSize;
  final double? nameTextWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 채널 프로필 이미지
        if (imgUrl.hasData)
          RoundProfileImg(
            size: imgSize,
            imgUrl: imgUrl,
          )
        else
          SkeletonBox(
            width: imgSize,
            height: imgSize,
            borderRadius: 100,
          ),
        AppSpace.size10,
        // 채널명
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (name.hasData)
              SizedBox(
                width: nameTextWidth,
                child: Text(
                  name!,
                  style:
                      AppTextStyle.headline3.copyWith(fontSize: nameFontSize),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            else ...[
              const SkeletonBox(
                width: 80,
                height: 20,
              ),
              AppSpace.size2,
            ],
            if (subscriberCount.hasData)
              Text(
                '구독자 ${Formatter.formatNumberWithUnit(subscriberCount)}명',
                style: AppTextStyle.body1.copyWith(
                  color: AppColor.lightGrey,
                  fontSize: subscriberFontSize,
                ),
              )
            else
              const SkeletonBox(
                width: 180,
                height: 22,
              ),
          ],
        ),
      ],
    );
  }
}
