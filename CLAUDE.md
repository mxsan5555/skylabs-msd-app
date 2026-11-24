# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Flutter app (`msd`), SDK constraint `^3.12.0`. Currently at the default counter-app scaffold — no feature code yet.

## Commands

```bash
# Run on a connected device or emulator
flutter run

# Run on a specific platform
flutter run -d android
flutter run -d ios
flutter run -d chrome

# Hot reload (while app is running)
r

# Hot restart (while app is running)
R

# Build
flutter build apk           # Android release APK
flutter build appbundle     # Android App Bundle (Play Store)
flutter build ios           # iOS (requires macOS)

# Lint and static analysis
flutter analyze

# Format
dart format lib/

# Tests
flutter test                          # all tests
flutter test test/widget_test.dart    # single file

# Dependencies
flutter pub get
flutter pub upgrade
flutter pub outdated
```

## Architecture

Entry point is `lib/main.dart`. As the project grows, use this folder structure:

```
lib/
  main.dart              # app entry, MaterialApp setup
  app.dart               # optional: extract MaterialApp here
  features/              # one folder per feature
    <feature>/
      screens/           # top-level screens (Scaffold widgets)
      widgets/           # feature-local widgets
      models/            # data models
      services/          # API / business logic
  shared/
    widgets/             # reusable cross-feature widgets
    theme/               # ThemeData, color scheme, text styles
    utils/               # helpers, extensions
```

## Stack Conventions

- State management: choose one (Riverpod preferred, or Provider/Bloc) and apply consistently — do not mix.
- Navigation: `go_router` when routes exceed 3 screens.
- HTTP: `dio` or `http` package; wrap in a service class, never call directly from widgets.
- Local storage: `shared_preferences` for simple KV, `sqflite` or `isar` for structured data.
- Theme: define `ThemeData` once in `shared/theme/`; never hardcode colors or text styles inline.

## Agent Routing

- New screens / widgets → Vega
- Design tokens / component spec → Reva
- Backend API → Kavan
- Database / auth → Neel
- Deploy / CI → Arjun
- Tests / security → Vivek
