import 'package:flutter/material.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/presentation/components/image_with_shimmer.dart';

import 'package:movies_app/core/resources/app_colors.dart';
import 'package:movies_app/core/resources/app_values.dart';
import 'package:movies_app/core/utils/functions.dart';

class SectionListViewCard extends StatelessWidget {
  final Media media;

  const SectionListViewCard({
    required this.media,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: AppSize.s120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              navigateToDetailsView(context, media);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s8),
              child: ImageWithShimmer(
                imageUrl: media.posterUrl,
                width: double.infinity,
                height: AppSize.s175,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                media.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star_rate_rounded,
                    color: AppColors.ratingIconColor,
                    size: AppSize.s18,
                  ),
                  Text(
                    '${media.voteAverage}/10',
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
