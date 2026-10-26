import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../l10n/app_localizations.dart';
import '../application/settings_controller.dart';
import '../domain/app_settings.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _SectionHeader(l10n.language),
          Card(
            child: RadioGroup<AppLanguage>(
              groupValue: settings.language,
              onChanged: (v) => controller.setLanguage(v!),
              child: Column(
                children: [
                  for (final (lang, label) in [
                    (AppLanguage.arabic, l10n.languageArabic),
                    (AppLanguage.english, l10n.languageEnglish),
                    (AppLanguage.system, l10n.languageSystem),
                  ])
                    RadioListTile<AppLanguage>(
                      key: Key('lang_${lang.name}'),
                      value: lang,
                      title: Text(label),
                    ),
                ],
              ),
            ),
          ),
          _SectionHeader(l10n.appearance),
          SegmentedButton<ThemeMode>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(
                value: ThemeMode.system,
                icon: const Icon(Icons.brightness_auto_rounded),
                label: Text(l10n.themeSystem),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                icon: const Icon(Icons.light_mode_rounded),
                label: Text(l10n.themeLight),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                icon: const Icon(Icons.dark_mode_rounded),
                label: Text(l10n.themeDark),
              ),
            ],
            selected: {settings.themeMode},
            onSelectionChanged: (s) => controller.setThemeMode(s.first),
          ),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.shield_outlined),
                  title: Text(l10n.privacyAndData),
                  subtitle: Text(l10n.privacyAndDataDesc),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => context.push(AppRoutes.privacy),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                ListTile(
                  leading: const Icon(Icons.workspace_premium_outlined),
                  title: Text(l10n.subscription),
                  subtitle: Text(l10n.subscriptionDesc),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => context.push(AppRoutes.subscription),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(4, 16, 4, 8),
      child: Semantics(
        header: true,
        child: Text(
          text,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
