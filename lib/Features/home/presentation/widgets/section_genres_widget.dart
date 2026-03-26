import 'package:flutter/material.dart';
import 'package:movies_app_project/core/l10n/app_localizations.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';

class SectionGenresWidget extends StatelessWidget {
  final List<String> genres;
  const SectionGenresWidget({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(appLocalizations.genres, style: theme.textTheme.titleLarge),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8, runSpacing: 8,
          children: genres.map((genre) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.greyColor.withOpacity(0.3),
            ),
            child: Text(genre, style: theme.textTheme.bodyMedium),
          )).toList(),
        ),
      ],
    );
  }
}