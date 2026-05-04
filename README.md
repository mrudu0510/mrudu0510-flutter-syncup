# SyncUp - Accountability Partner Matching App

A Flutter app that matches people based on shared goals, commitment levels, and availability to help them achieve their objectives together.

## 🎯 Features

- **Smart Matching Algorithm**: Matches partners based on goals, skill levels, availability, frequency, and working style
- **Swipe Interface**: Tinder-style swiping to find compatible partners
- **Real-time Chat**: Direct messaging with matched partners
- **Comprehensive Onboarding**: 7 essential questions to create your profile
- **Match Tracking**: View all matches with compatibility scores
- **Multiple Goal Categories**: Video Editing, Content Writing, Running, Exercising, Academic Study, Coding, and more

## 🚀 Quick Start

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio or Xcode

### Installation

```bash
# Clone the repository
git clone https://github.com/mrudu0510/mrudu0510-flutter-syncup.git
cd mrudu0510-flutter-syncup

# Get dependencies
flutter pub get

# Run the app
flutter run -d emulator-5554
```

## 📱 App Flow

1. **Login/Sign Up** - Create your account
2. **Onboarding** - Answer 7 profile questions
3. **Swipe** - Browse potential accountability partners
4. **Matches** - View all your matches
5. **Chat** - Message and plan with your partner

## 🧠 Onboarding Questions

1. What's your name?
2. What goal are you working on?
3. What's your current level? (Beginner/Intermediate/Advanced)
4. Preferred time to work? (Morning/Afternoon/Evening/Night)
5. How often will you work on this? (Daily/3-4x week/Weekends)
6. What's your working style? (Chill/Structured/Competitive)
7. How do you want to collaborate? (Chat/Voice-Video/Check-ins)

## 🎯 Matching Algorithm

Compatibility Score = 
- Goal Match (40%)
- Level Compatibility (20%)
- Availability Overlap (15%)
- Frequency Match (15%)
- Working Style Compatibility (10%)

## 📁 Project Structure

```
lib/
├── main.dart
├── theme/
│   └── app_theme.dart
└── screens/
    ├── login_screen.dart
    ├── onboarding_screen.dart
    ├── swipe_screen.dart
    ├── matches_screen.dart
    ├── chat_screen.dart
    └── profile_screen.dart
```

## 🛠️ Tech Stack

- Flutter & Dart
- Material Design 3
- Local state management (StatefulWidget)
- Mock data for testing

## 🔄 Future Enhancements

- Firebase integration for real-time data
- Push notifications
- Goal tracking and progress updates
- Video call integration
- Gamification features
- AI-powered matching

## 📝 License

This project is open source and available under the MIT License.

## 👨‍💻 Author

Sushruth Kumar M B

---

**Made with ❤️ to help people achieve their goals together!**
