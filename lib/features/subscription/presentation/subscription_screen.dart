import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

/// Explains the plans. Purchasing is intentionally not wired up yet: store
/// billing is added in a later phase after the store policies are verified.
class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.subscription)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _PlanCard(title: l10n.planFree, features: l10n.planFreeFeatures),
          const SizedBox(height: 12),
          _PlanCard(
            title: l10n.planPlus,
            features: l10n.planPlusFeatures,
            highlighted: true,
          ),
          const SizedBox(height: 24),
          Card(
            color: theme.colorScheme.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          l10n.subscriptionNotAvailable,
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(l10n.subscriptionNotAvailableBody),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.title,
    required this.features,
    this.highlighted = false,
  });

  final String title;
  final String features;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: highlighted ? scheme.tertiary : scheme.outlineVariant,
          width: highlighted ? 2 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            for (final line in features.split('\n'))
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_rounded, size: 20, color: scheme.primary),
                    const SizedBox(width: 8),
                    Expanded(child: Text(line)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
