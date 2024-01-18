part of 'premium_bloc.dart';

@freezed
class PremiumState with _$PremiumState {
  const factory PremiumState.loading() = PremiumLoadingState;
  const factory PremiumState.fail() = PremiumFailState;

  const factory PremiumState.listMostBuyVideos({
    @Default([]) List<VideoDetailModel> listMostBuyVideos,
    @Default(1) int page,
    @Default(false) bool haveClearData,
  }) = PremiumListMostBuyVideosState;
  const factory PremiumState.listChannelYouMightLike({
    @Default([]) List<ChannelMightLike> listChannelYouMightLike,
  }) = PremiumListChannelYouMightLikeState;

}
