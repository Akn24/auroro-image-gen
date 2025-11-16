# Aurora Image Generator

A Flutter app that fetches random images from an API, displays them centered as a square, and adapts the background color based on the image palette. It supports mobile, tablet, and desktop layouts with smooth transitions.

---

## Features

- Single-screen UI
- Square image centered on the screen
- Background color adapts to the image’s dominant color
- "Another" button to fetch a new random image
- Smooth image and background transitions
- Loading and error states
- Light/Dark mode support
- Responsive layouts (mobile, tablet, desktop)
- Basic accessibility support

---

## Demo
[![Watch the video](https://img.shields.io/badge/Watch-Demo-blue)](demo_assets/demo_aurora.mp4)

---

## Getting Started

### Prerequisites

- Flutter 3.0+
- Dart SDK
- An editor like VS Code or Android Studio

### Installation

1. Clone the repository:

```bash
git clone <your-repo-url>
cd aurora_image_gen
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

---

## Project Structure

```
lib/
├─ app/
│  └─ app.locator.dart        
├─ models/
│  └─ generated_image.model.dart
├─ services/
│  └─ api_service.dart        
├─ ui/
│  ├─ home/
│  │  ├─ home_view.dart       
│  │  ├─ home_view.mobile.dart
│  │  ├─ home_view.tablet.dart
│  │  ├─ home_view.desktop.dart
│  │  └─ home_viewmodel.dart
└─ main.dart
```

---

## API

- Endpoint: `GET /image`
- Returns a JSON object:

```json
{
  "url": "https://images.unsplash.com/photo-1506744038136-46273834b3fb"
}
```

- CORS is enabled; image URLs come from Unsplash.

---

## How It Works

1. **ViewModel (`HomeViewModel`)**  
   - Handles fetching images and generating the color palette.
   - Keeps track of `imageUrl`, `nextImageUrl`, `backgroundColor`, and `err`.
   - Prefetches the next image for smooth transitions.
   - Uses `PaletteGenerator` to extract the dominant color.

2. **Mobile / Tablet / Desktop Views**  
   - Display a square image centered on the screen.
   - Show loading spinner while fetching.
   - Animate image and background changes.
   - Display error messages if the fetch fails.
   - Button labeled "Another" to fetch a new image.

---

## Dependencies

- [stacked](https://pub.dev/packages/stacked) – MVVM architecture
- [cached_network_image](https://pub.dev/packages/cached_network_image) – Image caching
- [palette_generator](https://pub.dev/packages/palette_generator) – Extract dominant colors
- [dio](https://pub.dev/packages/dio) – API requests
- [responsive_builder](https://pub.dev/packages/responsive_builder) – Responsive layouts

---

## Usage

1. Launch the app.
2. The first image is automatically fetched.
3. Tap the **Another** button to fetch a new image.
4. Observe the background color smoothly adapting to the image.

---

## Notes

- Large images are optimized for display using URL parameters.
- Palette generation uses a smaller image for faster processing.
- Handles errors gracefully and shows a placeholder if an image fails to load.
- Supports light/dark mode themes.

---

## Contributing

Contributions are welcome! Please open issues or pull requests for:

- Bug fixes
- Performance improvements
- Additional features

---
