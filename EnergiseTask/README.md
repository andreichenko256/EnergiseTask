# EnergiseTask

A mini iOS application prototype featuring a chatbot, IP-based API content, chat history, and settings. Built as an MVP with scalability and clean architecture in mind.

## 🚀 Overview

**EnergiseTask** is a Swift-based iOS app (iOS 16+) using the MVC architecture and UIKit for all UI components. The app demonstrates real-world scenarios: text input, API interaction, local data persistence, and basic settings, all with a focus on clean, logical, and stable implementation.

---

## ✨ Features

- **Chat Screen**
  - User sends messages and receives random replies from a predefined array.
  - Messages are persisted locally.
  - Chat displayed via `UITableView` for smooth, native experience.

- **IP Info Screen**
  - Fetches and displays geolocation data from [ip-api.com](https://ip-api.com/).
  - Shows a map with the user's location and all API data in a user-friendly UI.
  - Includes a **Reload** button to refresh data.

- **Chat History Screen**
  - Lists all chat sessions with dates and first messages.
  - Users can view or delete any chat.

- **Settings Screen**
  - **Rate App**: Shows an alert for app rating.
  - **Share App**: Opens the share sheet.
  - **Contact Us**: Opens a link in the browser.

---

## 🛠️ Tech Stack

- **Language:** Swift
- **Architecture:** MVC
- **UI:** UIKit (all elements built programmatically)
- **Persistence:** Core Data, UserDefaults
- **Networking:** URLSession
- **Layout:** SnapKit
- **Localization:** English & German
- **Animations:** Smooth transitions for a modern feel

---

## 📱 Screenshots

> _Add your screenshots here to showcase each screen!_

---

## 🗂 Project Structure

```
EnergiseTask/
│
├── App/                  # AppDelegate & SceneDelegate
├── CommonItems/          # Shared UI components and models
│   ├── MainView.swift
│   ├── PrimaryButton.swift
│   └── Models/
│       └── GeoResponse.swift
├── Controllers/          # All feature modules
│   ├── Chat/             # Chat screen (VC, models, views, cells)
│   ├── FullChat/         # Full chat view
│   ├── History/          # Chat history
│   ├── Launch/           # Launch screen
│   ├── Location/         # IP info screen
│   ├── Settings/         # Settings screen
│   └── TabBar/           # Custom tab bar
├── Managers/             # CoreData, Network, Haptics, Permissions, UserDefaults
├── Resource/             # Assets, fonts, CoreData model, launch screen
├── Utils/                # Extensions, typealiases
└── Info.plist
```

---

## 🌍 Localization

- The app supports both **English** and **German**.
- All user-facing strings are localized.

---

## 🧑‍💻 How to Run

1. Clone the repository.
2. Open `EnergiseTask.xcodeproj` in Xcode 15+.
3. Select a simulator (iOS 16+).
4. Build and run.

---

## 📦 Dependencies

- [SnapKit](https://github.com/SnapKit/SnapKit) — for concise Auto Layout code.

---

## 📝 Notes

- All UI is built programmatically (no Storyboards except LaunchScreen).
- The app is designed for easy scaling and clean code maintenance.
- Animations and transitions are implemented for a smooth user experience.
- The codebase follows MVC and iOS best practices.

---

## 📄 License

MIT License. See [LICENSE](LICENSE) for details. 