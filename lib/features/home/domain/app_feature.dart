import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

/// Every user-facing feature listed on the home screen.
///
/// [isAvailable] is the single switch that turns a feature on. A feature stays
/// `false` until it is actually implemented end-to-end, so the UI never
/// presents something that does not work.
enum AppFeature {
  capture(Icons.photo_camera_rounded, isAvailable: false),
  gallery(Icons.photo_library_rounded, isAvailable: false),
  scanDocument(Icons.document_scanner_rounded, isAvailable: false),
  imageToText(Icons.text_snippet_rounded, isAvailable: false),
  translate(Icons.translate_rounded, isAvailable: false),
  askBaseer(Icons.auto_awesome_rounded, isAvailable: false),
  invoices(Icons.receipt_long_rounded, isAvailable: false),
  learning(Icons.school_rounded, isAvailable: false),
  history(Icons.history_rounded, isAvailable: false),
  savedFiles(Icons.folder_rounded, isAvailable: false);

  const AppFeature(this.icon, {required this.isAvailable});

  final IconData icon;
  final bool isAvailable;

  /// Features shown in the home grid (capture & gallery have their own bar).
  static const grid = [
    scanDocument,
    imageToText,
    translate,
    askBaseer,
    invoices,
    learning,
    history,
    savedFiles,
  ];

  String title(AppLocalizations l10n) => switch (this) {
    capture => l10n.captureButton,
    gallery => l10n.galleryButton,
    scanDocument => l10n.featureScanDocument,
    imageToText => l10n.featureImageToText,
    translate => l10n.featureTranslate,
    askBaseer => l10n.featureAskBaseer,
    invoices => l10n.featureInvoices,
    learning => l10n.featureLearning,
    history => l10n.featureHistory,
    savedFiles => l10n.featureSavedFiles,
  };

  String? description(AppLocalizations l10n) => switch (this) {
    scanDocument => l10n.featureScanDocumentDesc,
    imageToText => l10n.featureImageToTextDesc,
    translate => l10n.featureTranslateDesc,
    askBaseer => l10n.featureAskBaseerDesc,
    invoices => l10n.featureInvoicesDesc,
    learning => l10n.featureLearningDesc,
    history => l10n.featureHistoryDesc,
    savedFiles => l10n.featureSavedFilesDesc,
    capture || gallery => null,
  };
}
