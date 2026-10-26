import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/app_feature.dart';
import 'feature_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static void openFeature(BuildContext context, AppFeature feature) {
    if (!feature.isAvailable) {
      final l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(l10n.featureNotReady(feature.title(l10n)))),
        );
      return;
    }
    // Routes for features are registered as each one is implemented.
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    // With very large text, two columns get cramped; fall back to one.
    final singleColumn = MediaQuery.textScalerOf(context).scale(1) > 1.6;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.appName,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          Text(
                            l10n.tagline,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.tertiary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: l10n.settings,
                      icon: const Icon(Icons.tune_rounded),
                      onPressed: () => context.push(AppRoutes.settings),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              sliver: SliverToBoxAdapter(
                child: Text(
                  l10n.homeGreeting,
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList.list(
                children: [
                  for (final row in _rows(singleColumn ? 1 : 2))
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            for (var i = 0; i < row.length; i++) ...[
                              if (i > 0) const SizedBox(width: 12),
                              Expanded(
                                child: FeatureTile(
                                  feature: row[i],
                                  onTap: () => openFeature(context, row[i]),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
          ],
        ),
      ),
      // Primary actions sit at the bottom, within thumb reach.
      bottomNavigationBar: const _CaptureBar(),
    );
  }

  static List<List<AppFeature>> _rows(int columns) => [
    for (var i = 0; i < AppFeature.grid.length; i += columns)
      AppFeature.grid.sublist(
        i,
        (i + columns).clamp(0, AppFeature.grid.length),
      ),
  ];
}

class _CaptureBar extends StatelessWidget {
  const _CaptureBar();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    const capture = AppFeature.capture;
    const gallery = AppFeature.gallery;

    return Material(
      color: theme.colorScheme.surfaceContainer,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Semantics(
                  label: capture.isAvailable
                      ? null
                      : l10n.featureNotReadySemantics(capture.title(l10n)),
                  excludeSemantics: !capture.isAvailable,
                  button: true,
                  child: FilledButton.icon(
                    key: const Key('captureButton'),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(64),
                    ),
                    onPressed: capture.isAvailable
                        ? () => HomeScreen.openFeature(context, capture)
                        : null,
                    icon: const Icon(Icons.photo_camera_rounded, size: 28),
                    label: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          capture.title(l10n),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (!capture.isAvailable)
                          Text(
                            l10n.comingSoon,
                            style: const TextStyle(fontSize: 12),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: OutlinedButton.icon(
                  key: const Key('galleryButton'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(64),
                  ),
                  onPressed: gallery.isAvailable
                      ? () => HomeScreen.openFeature(context, gallery)
                      : null,
                  icon: const Icon(Icons.photo_library_rounded),
                  label: Text(
                    gallery.title(l10n),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
