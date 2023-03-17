import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/app_values.dart';
import 'package:movies_app/tv_shows/domain/entities/season.dart';
import 'package:movies_app/tv_shows/presentation/components/season_card.dart';

class SeasonsSection extends StatelessWidget {
  const SeasonsSection({
    super.key,
    required this.seasons,
    required this.tmdbID,
  });

  final List<Season> seasons;
  final int tmdbID;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: AppSize.s400),
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        physics: const BouncingScrollPhysics(),
        itemCount: seasons.length,
        itemBuilder: (context, index) => SeasonCard(
          season: seasons[index],
          tvShowId: tmdbID,
        ),
        separatorBuilder: (context, index) =>
            const SizedBox(height: AppSize.s10),
      ),
    );
  }
}
