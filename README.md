# 🎓 StudentHub

A modern Flutter application for managing student information with real API integration, featuring login authentication, student list/detail views, and user profile management.

**Build with:** Flutter | Provider State Management | MVVM Architecture

---

## 📋 Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Installation & Setup](#installation--setup)
- [Dependencies](#dependencies)
- [API Integration](#api-integration)
- [Testing](#testing)
- [Git Workflow](#git-workflow)
- [Running the App](#running-the-app)
- [Building APK](#building-apk)
- [Troubleshooting](#troubleshooting)
- [Design System](#design-system)
- [Code Quality](#code-quality)
- [Future Improvements](#future-improvements)

---

## ✨ Features

### Core Functionality
- ✅ **Real API Integration** - No hardcoded data, all API calls are live
- ✅ **Secure Login** - Username/password authentication with session persistence
- ✅ **Student Management** - View list of students with detailed profiles
- ✅ **User Profile** - Display logged-in user information with logout option
- ✅ **Navigation** - Seamless routing between all screens

### User Experience
- ✅ **Complete State Management** - Loading, Success, Error, and Empty states
- ✅ **Form Validation** - Real-time email & password validation with feedback
- ✅ **Pull-to-Refresh** - Refresh student list with gesture
- ✅ **Search Functionality** - Local filtering of students by name or email
- ✅ **Session Persistence** - Auto-login if already authenticated
- ✅ **Dark Mode Support** - Full dark theme implementation
- ✅ **Responsive Design** - Optimized for various phone screen sizes
- ✅ **Clickable Contacts** - Email/phone/website integration

### Code Quality
- ✅ **Custom Exceptions** - Specific error types for different failure scenarios
- ✅ **Validators** - Reusable validation functions (email, password, phone, etc)
- ✅ **Extensions** - Dart and Kotlin-like utility extensions for strings, dates, etc
- ✅ **Error Handling** - Comprehensive error handling at all layers
- ✅ **Clean Architecture** - MVVM pattern with clear separation of concerns

---

## 🏗️ Architecture

### MVVM Pattern

This project uses **Model-View-ViewModel (MVVM)** architecture:
┌─────────────────────────────────────┐
│ UI Layer (View) │
│ - Screens & Widgets │
│ - No business logic │
│ - Observes ViewModel state │
└──────────────┬──────────────────────┘
│ Observes & Updates
▼
┌─────────────────────────────────────┐
│ Logic Layer (ViewModel) │
│ - State management (Provider) │
│ - Business logic │
│ - Error handling │
└──────────────┬──────────────────────┘
│ Uses
▼
┌─────────────────────────────────────┐
│ Data Layer (Service) │
│ - API calls │
│ - Local storage │
│ - Data validation │
└──────────────┬──────────────────────┘
│ Manipulates
▼
┌─────────────────────────────────────┐
│ Model Layer (Model) │
│ - Data structures │
│ - Custom exceptions │
│ - Constants │
└─────────────────────────────────────┘

### Why MVVM?
- **Testability** - ViewModels are pure Dart classes, easy to unit test
- **Reusability** - Services and ViewModels can be reused across screens
- **Maintainability** - Clear separation of concerns makes debugging easier
- **Scalability** - Easy to add new features without touching existing code
- **Provider Native** - Provider package is designed for this pattern

---

## 📁 Project Structure
mini-school-app/

│

├── lib/

│   ├── config/

│   │   ├── app_theme.dart              # Light/Dark themes and colors

│   │   ├── app_constants.dart          # API endpoints and constants

│   │   └── routes.dart                 # Route definitions

│   │

│   ├── models/

│   │   ├── user_model.dart             # User data structure

│   │   ├── student_model.dart          # Student data structure

│   │   └── api_response.dart           # Generic API response wrapper

│   │

│   ├── services/

│   │   ├── api_service.dart            # Base HTTP client

│   │   ├── auth_service.dart           # Login/logout API

│   │   └── student_service.dart        # Student API calls

│   │

│   ├── viewmodels/

│   │   ├── auth_viewmodel.dart         # Login/logout logic

│   │   ├── student_list_viewmodel.dart # Student list logic

│   │   ├── student_detail_viewmodel.dart # Student detail logic

│   │   └── profile_viewmodel.dart      # Profile logic

│   │

│   ├── screens/

│   │   ├── splash/

│   │   │   └── splash_screen.dart

│   │   ├── login/

│   │   │   └── login_screen.dart

│   │   ├── student_list/

│   │   │   └── student_list_screen.dart

│   │   ├── student_detail/

│   │   │   └── student_detail_screen.dart

│   │   └── profile/

│   │       └── profile_screen.dart

│   │

│   ├── widgets/

│   │   ├── custom_text_field.dart      # Reusable text field         

│   │   ├── loading_widget.dart         # Loading spinner

│   │   ├── error_widget.dart           # Error display

│   │   ├── empty_state_widget.dart     # Empty state message

│   │   ├── notification_dialog.dart    # Notification dialog

│   │   └── student_card.dart           # Student list card

│   │

│   ├── utils/

│   │   ├── exceptions.dart             # Custom exceptions

│   │   ├── validators.dart             # Form validation functions

│   │   └── extensions.dart             # Dart extensions

│   │

│   └── main.dart                       # App entry point

├── pubspec.yaml                        # Dependencies

└── README.md                           # This file
---

## 📦 Prerequisites

- **Flutter** (version 3.10+) - Download from https://flutter.dev
- **Dart** (comes with Flutter)
- **Android Studio** or **Xcode** (for emulator)
- **VS Code** (recommended for editing)
- **Git** with GitHub Desktop

Verify setup:
```bash
flutter --version
dart --version
```

---

## 🚀 Installation & Setup

### Step 1: Clone Repository

```bash
git clone https://github.com/MinahilAyaz/mini-school-app.git
cd mini-school-app
```

### Step 2: Get Dependencies

```bash
flutter pub get
```

### Step 3: Verify Setup

```bash
flutter doctor
```

All checks should pass (✓).

### Step 4: Run App

```bash
flutter run
```

---

## 📚 Dependencies & Rationale

### State Management
```yaml
provider: ^6.0.0
```
**Why:** Industry standard for MVVM. Lightweight, testable, no boilerplate code.

### Networking
```yaml
http: ^1.1.0
```
**Why:** Simple HTTP client. No heavy abstractions, great for learning real API integration.

### Local Storage
```yaml
shared_preferences: ^2.2.0
```
**Why:** Persistent session tokens. Used for session persistence and auto-login.

### JSON Handling
```yaml
json_serializable: ^6.7.0
```
**Why:** Auto-generates JSON parsing. Type-safe, reduces manual errors.

### UI & Typography
```yaml
google_fonts: ^6.1.0
url_launcher: ^6.2.0
```
**Why:** Professional fonts and native integration for email/phone/web links.

### Utilities
```yaml
intl: ^0.19.0
```
**Why:** Date/time formatting and internationalization support.

---

## 🔌 API Integration

### Real APIs Used

#### 1. Login API
- **Service:** reqres.in (realistic fake API)
- **Endpoint:** `POST https://reqres.in/api/login`
- **Valid credentials:**
Email: eve.holt@reqres.in
Password: cityslickas
#### 2. Student List & Detail
- **Service:** JSONPlaceholder (free, public API)
- **Endpoints:**
  - `GET https://jsonplaceholder.typicode.com/users` - List of 10 students
  - `GET https://jsonplaceholder.typicode.com/users/{id}` - Single student

### Error Handling

The app distinguishes between error types:
NetworkException     → No internet or connection issues

AuthException        → Login failed or invalid credentials

ValidationException  → Form validation errors

ServerException      → 500+ HTTP errors

ParsingException     → Invalid JSON response

UnknownException     → Unexpected errors
Each error type gets different UI treatment:
- **Network:** "Check your internet connection"
- **Auth:** "Invalid email or password"
- **Validation:** Inline error on form field
- **Server:** "Server is temporarily unavailable"

---

## 🧪 Testing

### Run All Tests
```bash
flutter test
```

## 🔄 Git Workflow

### Commit Naming
feat: Add new feature
fix: Fix a bug
design: Design/styling changes
test: Add/update tests
refactor: Code reorganization
docs: Documentation updates
### Example Commit History
1. feat: Initialize Flutter project
2. feat: Add project dependencies
3. design: Define theme and colors
4. feat: Create data models
5. feat: Implement API service layer
6. feat: Create ViewModels with Provider
7. feat: Build Login screen UI
8. feat: Build Student List screen
9. feat: Build Student Detail screen
10. feat: Build Profile screen
11. test: Add unit test
### Push Changes
After each feature:
```bash
# In GitHub Desktop:
1. Write commit message
2. Click "Commit to main"
3. Click "Push origin"
```

---

## ▶️ Running the App

### Debug Mode
```bash
flutter run
```

### Release Mode (Optimized)
```bash
flutter run --release
```

### Device Selection
```bash
flutter devices          # List devices
flutter run -d <device_id>
```

### With Hot Reload
Press 'r' in terminal to reload
Press 'R' to restart
---

## 📦 Building APK

### Debug APK (for testing)
```bash
flutter build apk --debug
# Output: build/app/outputs/apk/debug/app-debug.apk
```

### Release APK (for distribution)
```bash
flutter build apk --release
# Output: build/app/outputs/apk/release/app-release.apk
```

### Configure Signing (Android)
1. Create keystore file
2. Configure in `android/key.properties`
3. Update `android/app/build.gradle`

---

## ❓ Troubleshooting

### "flutter: command not found"
Add Flutter to PATH environment variable.

### "No devices found"
```bash
flutter emulators --launch pixel_5
# or connect physical device with USB debugging
```

### "Gradle sync failed"
```bash
flutter clean
flutter pub get
flutter run
```

### "Hot reload not working"
Restart the app by pressing 'R' in terminal.

### "API calls returning errors"
- Check internet connection
- Verify API endpoints in `app_constants.dart`
- Check request/response format in services

### "Login not persisting"
- Ensure SharedPreferences initialized
- Check token saved correctly
- Verify session restore in AuthService

### "Dark mode not showing"
- Go to phone Settings → Display & Brightness → Dark/Light
- Or system automatically follows device setting

---

## 🎨 Design System

### Color Palette

The app uses a modern, soft-toned educational color system designed for readability and accessibility in both light and dark modes.

## Primary Colors
Primary Blue (Mauve/Purple): #987D9A
Used for main actions, highlights, and primary UI elements.

## Secondary Purple: #BB9AB1
Used for secondary accents and supporting UI components.

## Accent Colors
Accent Orange (Beige/Tan): #EECEB9

## Used for subtle highlights and decorative elements.
Accent Yellow (Cream): #FEFBD8
Used for soft background accents.

## Background Colors
Light Background: #FAFBFC
Used in light mode screens.
Dark Background: #121212
Used in dark mode for high contrast and reduced eye strain.

## Text Colors (Light Mode)
Primary Text: #212121
Secondary Text: #757575
Text Colors (Dark Mode)
Primary Text: #FAFBFC (high contrast white)
Secondary Text: #BDBDBD (light gray for muted content)

## Status Colors
Success: #43A047
Error: #E53935
Warning: #FB8C00

## Dividers
Light Mode Divider: #E0E0E0
Dark Mode Divider: #424242


### Typography
**Font:** Google Fonts - Poppins

- **32px Bold** - Page titles
- **24px Bold** - Section titles  
- **18px SemiBold** - Card titles
- **16px Medium** - Main content
- **14px Regular** - Secondary content
- **12px Regular** - Captions

### Components
- **Border radius:** 12px (consistent)
- **Button height:** 48-56px
- **Input field height:** 48-56px
- **Default padding:** 16px
- **Default spacing:** 8, 16, 24px (multiples of 8)

---

## 💻 Code Quality

### Best Practices
- ✅ Clear variable/function naming
- ✅ Single responsibility principle
- ✅ DRY (Don't Repeat Yourself)
- ✅ Proper error handling
- ✅ Type safety with null safety
- ✅ Comments for complex logic
- ✅ Consistent code formatting

### Static Analysis
```bash
flutter analyze
```

### Auto-fix Issues
```bash
dart fix --apply
```

---

## 📈 Future Improvements

### Phase 2 Features
- [ ] **Search & Sort** - Advanced student filtering
- [ ] **Student Grades** - Display grades and GPA
- [ ] **Announcements** - Push notifications
- [ ] **Image Upload** - Profile picture feature
- [ ] **Offline Mode** - Cache data locally
- [ ] **Pagination** - Lazy load for large lists

### Code Enhancements
- [ ] **100% Test Coverage** - More comprehensive tests
- [ ] **Performance Profiling** - Optimize build time
- [ ] **API Versioning** - Support multiple API versions

### Architecture
- [ ] **Riverpod** - Modern state management alternative
- [ ] **GetIt** - Service locator for dependency injection
- [ ] **BLoC Pattern** - For complex state management
- [ ] **Hive** - Local database for offline support

---

## 📄 License

MIT License - See LICENSE file for details

---

## 🤝 Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Open Pull Request

---

## 📧 Support

Issues or questions?
- Open a GitHub Issue
- Check commit history for similar problems
- Review troubleshooting section above

---

## 🎯 Quick Reference

```bash
# Setup
flutter pub get
flutter doctor

# Development
flutter run                    # Debug
flutter run --release         # Release
flutter pub outdated          # Update check

# Testing
flutter test                   # All tests
flutter test test/validators_test.dart
flutter test --coverage

# Building
flutter build apk --debug     # Debug APK
flutter build apk --release   # Release APK

# Code Quality
flutter analyze               # Static analysis
dart fix --apply             # Auto-fix
dart format lib/            # Format code

# Utilities
flutter devices              # List devices
flutter clean                # Clean build
flutter pub get              # Get dependencies
```

---

**Last Updated:** June 202 6 
**Flutter Version:** 3.10+  
**Dart Version:** 3.0+  
**Status:** ✅ Feature Complete

