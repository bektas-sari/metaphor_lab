# MetaphorLab (Flutter APP)

*A minimalist, gamified Flutter app that helps you practice creative thinking by crafting metaphors from a random **Object + Concept** pair.*

> **Tagline:** “Turn abstract ideas into vivid pictures — one metaphor at a time.”

---

## Table of Contents

* [Features](#features)
* [Screens](#screens)
* [Architecture](#architecture)
* [Game Mechanics & Scoring](#game-mechanics--scoring)
* [Data & Privacy](#data--privacy)
* [Tech Stack](#tech-stack)
* [Project Structure](#project-structure)
* [Getting Started](#getting-started)
* [Build & Release](#build--release)
* [Troubleshooting](#troubleshooting)
* [Roadmap](#roadmap)
* [Contributing](#contributing)
* [License](#license)
* [Developer](#developer)

---

## Features

* 🎲 **Random Prompt Generator:** Combines a *concrete object* with an *abstract concept* to spark original metaphors.
* 🧠 **Lightweight Scoring:** Instant 0–100 score based on simple, transparent rules (see below).
* 🔥 **Daily Streak:** Keep momentum by writing at least one metaphor per day.
* 📜 **History:** View your previous metaphors with timestamps and scores.
* 🎨 **Clean UI/UX:** White & blue color palette, generous spacing, accessible touch targets (≥44px), **Roboto** font via Google Fonts.

> **Primary audience:** writers, educators, advertising & communication students, psychology students — and anyone who wants to sharpen imagination.

---

## Architecture

* **State management:** `provider` + `ChangeNotifier` (simple and explicit)
* **Local persistence:** `shared_preferences` (no backend required)
* **Assets:** small JSON lists for objects & concepts
* **Theming:** Material 3, custom palette, Roboto via `google_fonts`

Component layers:

* `core/` – theme, palette, general utilities
* `models/` – plain data models (Prompts & Entries)
* `services/` – persistence service (SharedPreferences)
* `state/` – `GameProvider` (prompts, scoring, streak, entries)
* `ui/` – feature screens and reusable widgets

---

## Game Mechanics & Scoring

**Goal:** Write a metaphor using the given **Object** and **Concept**. The app encourages the classic *“... like ..., because ...”* structure.

**Score (0–100):**

* +20 — Length ≥ 7 words
* +20 — Uses *“gibi”* or *“çünkü”* (Turkish for *“like”* / *“because”*)
* +15 — Mentions the **object**
* +15 — Mentions the **concept**
* +0…30 — **Diversity:** fewer repetitive words → higher score

**Daily streak:** increases when you submit at least one metaphor on a new day; breaks after missed days.

---

## Data & Privacy

* All data is stored **locally on device** via `SharedPreferences`.
* No external network calls are required in the MVP.
* You can clear app data from system settings to remove saved entries.

> Future versions may add optional cloud sync (Firebase/Supabase) — opt‑in only.

---

## Tech Stack

* **Flutter** (Material 3)
* **Dart**
* **provider** — state management
* **shared\_preferences** — local storage
* **google\_fonts** — Roboto
* **intl** — date formatting

---

## Project Structure

```text
lib/
  main.dart
  core/
    theme.dart
    palette.dart
    utils.dart
  data/
    prompts/
      objects.json
      concepts.json
  models/
    metaphor_entry.dart
    metaphor_prompt.dart
  services/
    storage_service.dart
  state/
    game_provider.dart
  ui/
    screens/
      home_screen.dart
      play_screen.dart
      history_screen.dart
      settings_screen.dart
    widgets/
      primary_button.dart
      prompt_card.dart
      score_chip.dart
```

---

## Getting Started

### Prerequisites

* Flutter (stable channel)
* Android Studio / Xcode for platform tooling

### Install & Run (Debug)

```bash
flutter pub get
flutter run
```

### Recommended pubspec entries

Make sure your JSON assets are declared:

```yaml
flutter:
  uses-material-design: true
  assets:
    - lib/data/prompts/objects.json
    - lib/data/prompts/concepts.json
```

---

## Build & Release

### Android APK

```bash
flutter build apk --release
```

### Android App Bundle (Play Store)

```bash
flutter build appbundle --release
```

### iOS

```bash
cd ios
pod install
cd ..
flutter build ipa --release
```

> Sign and upload with your platform’s standard process.

---

## Troubleshooting

### Android NDK version mismatch

Some plugins (e.g., `path_provider_android`, `shared_preferences_android`) may require a newer NDK. If you see an error like:

```
requires Android NDK 27.0.12077973
```

Add or update the `ndkVersion` in **`android/app/build.gradle.kts`**:

```kotlin
android {
    ndkVersion = "27.0.12077973"
    // ...
}
```

Then clean & rebuild:

```bash
flutter clean
flutter pub get
flutter run
```

### Card theme API changes

Material 3 expects `CardThemeData` instead of `CardTheme` in some Flutter versions. Use:

```dart
cardTheme: const CardThemeData(
  // ...
)
```

---

## Roadmap

* 🔎 Smarter scoring (semantic similarity, metaphor strength heuristics)
* 🗂️ Categories (Education, Advertising, Psychology)
* 🗣️ Localization (TR/EN UI)
* 🔔 Daily notifications (reminders)
* ☁️ Optional cloud sync (Firebase/Supabase)
* 🖼️ Share as image card (export a nicely styled quote card)

---

## Contributing

PRs and issues are welcome! If you plan a larger change, please open an issue to discuss scope and design first.

**Development guidelines**

* Keep UI minimal and accessible (contrast, tap size, semantics labels)
* Prefer small, focused widgets
* Keep `GameProvider` free of UI concerns
* Add screenshots to `screenshots/` when you change UI

---

## License

This project is licensed under the **MIT License**. See `LICENSE` for details.

---

## Developer

**Bektas Sari**
Email: [bektas.sari@gmail.com](mailto:bektas.sari@gmail.com) <br>
GitHub: [https://github.com/bektas-sari](https://github.com/bektas-sari)<br>
LinkedIn: [www.linkedin.com/in/bektas-sari](http://www.linkedin.com/in/bektas-sari)<br>
Researchgate: [https://www.researchgate.net/profile/Bektas-Sari-3](https://www.researchgate.net/profile/Bektas-Sari-3)<br>
Academia: [https://independent.academia.edu/bektassari](https://independent.academia.edu/bektassari)<br>

> If you use MetaphorLab in a class, workshop, or research, feel free to reach out — I’d love to hear about it.
