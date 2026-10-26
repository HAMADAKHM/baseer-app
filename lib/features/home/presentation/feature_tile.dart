import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/app_feature.dart';

/// A home-grid card. Unavailable features are visibly muted, carry a
/// "coming soon" badge and announce themselves as unavailable to screen
/// readers.
class FeatureTile extends StatelessWidget {
  const FeatureTile({super.key, required this.feature, required this.onTap});

  final AppFeature feature;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final enabled = feature.isAvailable;
    final title = feature.title(l10n);
    final description = feature.description(l10n);

    return Semantics(
      button: true,
      enabled: enabled,
      label: enabled ? title : l10n.featureNotReadySemantics(title),
      excludeSemantics: true,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Opacity(
            opacity: enabled ? 1 : .55,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: scheme.primaryContainer,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          feature.icon,
                          color: scheme.onPrimaryContainer,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: enabled
                              ? const SizedBox.shrink()
                              : _ComingSoonBadge(label: l10n.comingSoon),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (description != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ComingSoonBadge extends StatelessWidget {
  const _ComingSoonBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: scheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelSmall
            ?.copyWith(color: scheme.onTertiaryContainer),
      ),
    );
  }
}
