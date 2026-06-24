# 🎓 StudentHub

A modern Flutter application for managing student information with real API integration, featuring login authentication, student list/detail views, and user profile management.

**Build with:** Flutter | Provider State Management | MVVM Architecture | Unit Tests

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
- ✅ **Secure Login** - Email/password authentication with session persistence
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
- ✅ **Unit Tests** - Tests for ViewModels, Services, and Validators
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

│   │   ├── loading_widget.dart         # Loading spinner

│   │   ├── error_widget.dart           # Error display

│   │   ├── empty_state_widget.dart     # Empty state message

│   │   └── student_card.dart           # Student list card

│   │

│   ├── utils/

│   │   ├── exceptions.dart             # Custom exceptions

│   │   ├── validators.dart             # Form validation functions

│   │   └── extensions.dart             # Dart extensions

│   │

│   └── main.dart                       # App entry point

│

├── test/

│   ├── validators_test.dart            # Validator tests

│   ├── auth_viewmodel_test.dart        # AuthViewModel tests

│   └── student_list_viewmodel_test.dart # StudentListViewModel tests

│

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
git clone https://github.com/YOUR_USERNAME/mini-school-app.git
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

### Run Specific Test
```bash
flutter test test/validators_test.dart
```

### Run with Coverage
```bash
flutter test --coverage
```

### Tests Included

| Test File | Coverage |
|-----------|----------|
| `validators_test.dart` | Email, password, phone validation |
| `auth_viewmodel_test.dart` | Login, logout, error handling |
| `student_list_viewmodel_test.dart` | Fetch, search, filter students |

### Test Examples

```dart
test('validateEmail returns null for valid email', () {
  expect(Validators.validateEmail('test@example.com'), null);
});

test('login with invalid credentials shows error', () async {
  // Arrange - mock service
  when(mockAuthService.login(...)).thenThrow(AuthException(...));
  
  // Act
  await authViewModel.login(email, password);
  
  // Assert
  expect(authViewModel.errorMessage, isNotNull);
  expect(authViewModel.isLoggedIn, false);
});
```

---

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

### Colors
Primary Blue: 
#A9D6F5
Secondary Purple: 
#C9C3F5
Accent Yellow: 
#F2DC7D
Background Light: 
#F8FAFC
Background Dark: 
#1A202C
Text Primary: 
#2D3748
Text Secondary: 
#718096
Success: 
#48BB78
Error: 
#F56565
Warning: 
#ED8936
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
- [ ] **Integration Tests** - E2E UI testing
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

**Last Updated:** June 2025  
**Flutter Version:** 3.10+  
**Dart Version:** 3.0+  
**Status:** ✅ Feature Complete

