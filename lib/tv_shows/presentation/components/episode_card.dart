import 'package:flutter/material.dart';
import 'package:movies_app/core/presentation/components/image_with_shimmer.dart';
import 'package:movies_app/core/resources/app_strings.dart';
import 'package:movies_app/core/resources/app_values.dart';
import 'package:movies_app/tv_shows/domain/entities/episode.dart';

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({
    super.key,
    required this.episode,
  });

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: AppSize.s84,
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: AppPadding.p8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s8),
              child: ImageWithShimmer(
                imageUrl: episode.stillPath,
                width: AppSize.s150,
                height: double.infinity,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppStrings.episode} ${episode.number}',
                  style: textTheme.bodyMedium,
                ),
                Text(
                  episode.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyLarge,
                ),
                Text(
                  episode.airDate,
                  style: textTheme.bodyLarge,
                ),
                Text(
                  episode.runtime,
                  style: textTheme.bodyLarge,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
