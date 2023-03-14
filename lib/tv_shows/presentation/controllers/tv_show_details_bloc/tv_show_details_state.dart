part of 'tv_show_details_bloc.dart';

class TVShowDetailsState extends Equatable {
  const TVShowDetailsState({
    this.tvShowDetails,
    this.tvShowDetailsStatus = RequestStatus.loading,
    this.tvShowDetailsMessage = '',
    this.seasonDetails,
    this.seasonDetailsStatus = RequestStatus.loading,
    this.seasonDetailsMessage = '',
  });

  final MediaDetails? tvShowDetails;
  final RequestStatus tvShowDetailsStatus;
  final String tvShowDetailsMessage;
  final SeasonDetails? seasonDetails;
  final RequestStatus seasonDetailsStatus;
  final String seasonDetailsMessage;

  TVShowDetailsState copyWith({
    final MediaDetails? tvShowDetails,
    final RequestStatus? tvShowDetailsStatus,
    final String? tvShowDetailsMessage,
    final SeasonDetails? seasonDetails,
    final RequestStatus? seasonDetailsStatus,
    final String? seasonDetailsMessage,
  }) {
    return TVShowDetailsState(
      tvShowDetails: tvShowDetails ?? this.tvShowDetails,
      tvShowDetailsStatus: tvShowDetailsStatus ?? this.tvShowDetailsStatus,
      tvShowDetailsMessage: tvShowDetailsMessage ?? this.tvShowDetailsMessage,
      seasonDetails: seasonDetails ?? this.seasonDetails,
      seasonDetailsStatus: seasonDetailsStatus ?? this.seasonDetailsStatus,
      seasonDetailsMessage: seasonDetailsMessage ?? this.seasonDetailsMessage,
    );
  }

  @override
  List<Object?> get props => [
        tvShowDetails,
        tvShowDetailsStatus,
        tvShowDetailsMessage,
        seasonDetails,
        seasonDetailsStatus,
        seasonDetailsMessage
      ];
}
