import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app_project/core/l10n/app_localizations.dart';


class SectionScreenShotsWidget extends StatelessWidget {
  final List<String> images;
  const SectionScreenShotsWidget({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context)!;
    if (images.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(appLocalizations.screenShots, style: theme.textTheme.titleLarge),
        const SizedBox(height: 12),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: images.length,
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemBuilder: (context, index) => ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: images[index],
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
              placeholder: (_, _) => Container(
                height: 150,
                color: Colors.grey[900],
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white24,
                    strokeWidth: 2,
                  ),
                ),
              ),
              errorWidget: (_, _, _) {
                return Container(
                  height: 150,
                  color: Colors.black,
                  child: const Center(
                    child: Icon(
                      Icons.movie_outlined,
                      color: Colors.white24,
                      size: 40,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}