# SkyMind Weather App 🌤️

![Version](https://img.shields.io/badge/version-1.1.0-blue.svg)
![Flutter](https://img.shields.io/badge/Flutter-3.9.2-02569B?logo=flutter)
![License](https://img.shields.io/badge/license-MIT-green.svg)

A beautiful, feature-rich weather application built with Flutter following the MVVM (Model-View-ViewModel) architecture pattern.

## 📱 Features

- **Real-time Weather Data**: Get current weather information for any city worldwide
- **5-Day Forecast**: View detailed weather forecasts with interactive charts
- **Favorite Cities**: Save and manage your favorite locations
- **Weather Alerts**: Receive notifications for weather updates
- **🆕 Region Filter**: Browse and select cities by continent with popular cities quick access
- **Customizable Settings**: 
  - Dark/Light theme toggle
  - Temperature units (Celsius/Fahrenheit)
  - Wind speed units (km/h/mph)
  - Weather alert preferences
- **Share Weather**: Share current weather information with friends
- **Beautiful UI**: Modern, glassmorphic design with smooth animations

## 🆕 What's New in v1.1.0

- ✨ **Region Filter Feature**: Added comprehensive region-based city selection
  - Browse cities by continent (Asia, Europe, North America, South America, Africa, Oceania)
  - Quick access to 15 popular cities worldwide
  - Expandable region cards with major cities
  - One-tap city selection
- 🎨 **Enhanced UI**: Region filter button added next to Forecast button
- 🔄 **Improved Navigation**: Seamless integration with home screen weather display
- 📱 **Better UX**: Responsive button layout with Wrap widget for better mobile experience

## 🏗️ Architecture

This project follows the **MVVM (Model-View-ViewModel)** architecture pattern with a clean, organized folder structure:

```
lib/
├── main.dart
├── core/
│   ├── services/          # API, Database, and Notification services
│   │   ├── api_service.dart
│   │   ├── db_service.dart
│   │   └── notification_service.dart
│   └── utils/             # Constants and helper functions
│       ├── constants.dart
│       └── helpers.dart
├── features/              # Feature-based modules
│   ├── home/
│   │   ├── model/         # Data models
│   │   ├── view/          # UI screens
│   │   └── view_model/    # Business logic & state management
│   ├── forecast/
│   ├── favourites/
│   ├── alerts/
│   ├── region/            # 🆕 Region filter feature
│   └── settings/
└── shared_widgets/        # Reusable UI components
```

## 🛠️ Tech Stack

- **Framework**: Flutter 3.9.2
- **State Management**: Riverpod 2.6.1
- **Local Storage**: Hive 2.2.3
- **HTTP Client**: Dio 5.7.0
- **Charts**: FL Chart 0.69.2
- **Notifications**: Flutter Local Notifications 18.0.1
- **Location**: Geolocator 13.0.2
- **Background Tasks**: Workmanager 0.9.0

## 📦 Installation

### Prerequisites

- Flutter SDK (>=3.9.2)
- Android Studio / VS Code
- Android SDK (for Android builds)
- Git

### Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/salharifan/SkyMind.git
   cd SkyMind
   ```

2. **Checkout the latest version**
   ```bash
   git checkout mvvm-refactor-v1.0.0
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Generate code (for Hive adapters)**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## 📲 Download APK

**Latest Release: v1.1.0** 🆕

📥 [Download SkyMind-v1.1.0.apk](https://github.com/salharifan/SkyMind/releases/tag/v1.1.0)

The APK is also available locally at:
```
C:\Users\user\Downloads\SkyMind-v1.1.0.apk
```

**APK Size**: ~48.8 MB

### Previous Versions
- [v1.0.0](https://github.com/salharifan/SkyMind/releases/tag/v1.0.0) - Initial MVVM refactor

## 🔑 API Configuration

This app uses the OpenWeatherMap API. The API key is included for demonstration purposes. For production use, please:

1. Get your own API key from [OpenWeatherMap](https://openweathermap.org/api)
2. Replace the API key in `lib/core/services/api_service.dart`:
   ```dart
   final String apiKey = 'YOUR_API_KEY_HERE';
   ```

## 🚀 Building from Source

### Build APK (Release)
```bash
flutter build apk --release
```

### Build App Bundle (for Play Store)
```bash
flutter build appbundle --release
```

### Build for iOS
```bash
flutter build ios --release
```

## 📊 Version Control

This project uses Git for version control with semantic versioning:

- **Repository**: https://github.com/salharifan/SkyMind
- **Current Branch**: `mvvm-refactor-v1.0.0`
- **Latest Tag**: `v1.1.0` 🆕

### Version History

- **v1.1.0** (2025-12-09): Added Region Filter feature
  - Region-based city browsing
  - Popular cities quick access
  - Enhanced UI with better button layout
  - Improved user experience
  
- **v1.0.0** (2025-12-09): Complete MVVM architecture refactor
  - Simplified folder structure
  - Improved code organization
  - Enhanced maintainability
  - All features working correctly

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 📝 Code Quality

The project maintains high code quality standards:
- ✅ No analysis issues
- ✅ Follows Flutter best practices
- ✅ Clean architecture principles
- ✅ Proper separation of concerns

Run code analysis:
```bash
flutter analyze
```

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Author

**Salharifan**
- GitHub: [@salharifan](https://github.com/salharifan)

## 🙏 Acknowledgments

- OpenWeatherMap for providing the weather API
- Flutter team for the amazing framework
- All contributors and users of this app

## 📞 Support

If you encounter any issues or have questions:
- Open an issue on [GitHub](https://github.com/salharifan/SkyMind/issues)
- Check existing issues for solutions

## 🔄 Updates

### Latest Updates (v1.1.0)
- ✅ Region Filter feature
- ✅ Popular cities quick access
- ✅ Enhanced button layout
- ✅ Better mobile responsiveness

### Planned Features
- [ ] Hourly forecast
- [ ] Weather maps
- [ ] Multiple language support
- [ ] Widget support
- [ ] Apple Watch support

---

**Made with ❤️ using Flutter**
