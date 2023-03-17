import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/domain/entities/media_details.dart';
import 'package:movies_app/core/presentation/components/details_card.dart';
import 'package:movies_app/core/presentation/components/error_screen.dart';
import 'package:movies_app/core/presentation/components/loading_indicator.dart';
import 'package:movies_app/core/presentation/components/section_title.dart';
import 'package:movies_app/core/resources/app_strings.dart';
import 'package:movies_app/core/resources/app_values.dart';
import 'package:movies_app/core/services/service_locator.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/core/utils/functions.dart';
import 'package:movies_app/tv_shows/presentation/components/episode_card.dart';
import 'package:movies_app/tv_shows/presentation/components/seasons_section.dart';
import 'package:movies_app/tv_shows/presentation/components/tv_show_card_details.dart';

import 'package:movies_app/tv_shows/presentation/controllers/tv_show_details_bloc/tv_show_details_bloc.dart';

class TVShowDetailsView extends StatelessWidget {
  const TVShowDetailsView({
    super.key,
    required this.tvShowId,
  });

  final int tvShowId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<TVShowDetailsBloc>()..add(GetTVShowDetailsEvent(tvShowId)),
      child: Scaffold(
        body: BlocBuilder<TVShowDetailsBloc, TVShowDetailsState>(
          builder: (context, state) {
            switch (state.tvShowDetailsStatus) {
              case RequestStatus.loading:
                return const LoadingIndicator();
              case RequestStatus.loaded:
                return TVShowDetailsWidget(tvShowDetails: state.tvShowDetails!);
              case RequestStatus.error:
                return ErrorScreen(
                  onTryAgainPressed: () {
                    context
                        .read<TVShowDetailsBloc>()
                        .add(GetTVShowDetailsEvent(tvShowId));
                  },
                );
            }
          },
        ),
      ),
    );
  }
}

class TVShowDetailsWidget extends StatelessWidget {
  const TVShowDetailsWidget({
    super.key,
    required this.tvShowDetails,
  });

  final MediaDetails tvShowDetails;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailsCard(
            mediaDetails: tvShowDetails,
            detailsWidget: TVShowCardDetails(
              genres: tvShowDetails.genres,
              lastEpisode: tvShowDetails.lastEpisodeToAir!,
              seasons: tvShowDetails.seasons!,
            ),
          ),
          getOverviewSection(tvShowDetails.overview),
          const SectionTitle(title: AppStrings.lastEpisodeOnAir),
          EpisodeCard(episode: tvShowDetails.lastEpisodeToAir!),
          const SectionTitle(title: AppStrings.seasons),
          SeasonsSection(
            tmdbID: tvShowDetails.tmdbID,
            seasons: tvShowDetails.seasons!,
          ),
          getSimilarSection(tvShowDetails.similar),
          const SizedBox(height: AppSize.s8),
        ],
      ),
    );
  }
}
