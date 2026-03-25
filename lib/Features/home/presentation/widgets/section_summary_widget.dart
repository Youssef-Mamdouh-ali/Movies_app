import 'package:flutter/material.dart';
import 'package:movies_app_project/core/l10n/app_localizations.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';

class SectionSummaryWidget extends StatelessWidget {
  final String bodySummary;
  const SectionSummaryWidget({super.key, required this.bodySummary});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(appLocalizations.summary, style: theme.textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(
          bodySummary, 
          style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.whiteColor, height: 1.4),
        ),
      ],
    );
  }
}