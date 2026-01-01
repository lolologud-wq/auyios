# Building AyuGram for iOS

## Prerequisites

- macOS with Xcode installed
- CMake 3.25 or higher
- Qt for iOS (or Qt Quick/QML)
- iOS SDK

## Important Notes

⚠️ **iOS port is incomplete**. The current implementation provides basic platform structure but requires:

1. Complete UI rewrite from Qt Widgets to UIKit/SwiftUI (Qt Widgets are not supported on iOS)
2. Full Xcode project setup
3. iOS-specific build configuration
4. Additional platform modules implementation

## Current Status

Created iOS platform files:
- `platform/ios/specific_ios.h/mm` - Platform-specific functions
- `platform/ios/integration_ios.h/mm` - System integration
- `platform/ios/main_window_ios.h/mm` - Main window (needs UI rewrite)
- `platform/ios/file_utilities_ios.h/mm` - File operations
- `platform/ios/notifications_manager_ios.h/mm` - Notifications
- `platform/ios/tray_ios.h/mm` - System tray (not applicable on iOS)

## Обходные пути для сборки на Windows

### 1. GitHub Actions (Рекомендуется)

Используйте созданный `.github/workflows/build-ios.yml`:

1. Закоммитьте код в GitHub репозиторий
2. Перейдите в раздел "Actions" в репозитории
3. Выберите workflow "Build iOS" и запустите его вручную
4. GitHub предоставит бесплатный Mac runner для сборки

**Преимущества:**
- Бесплатно для публичных репозиториев
- Не требует локального Mac
- Автоматическая сборка при коммитах

### 2. Удаленный Mac (SSH)

Если у вас есть доступ к Mac (физический или виртуальный):

```bash
# На Windows: подключитесь к Mac через SSH
ssh user@mac-ip-address

# На Mac: выполните сборку
cd /path/to/AyuGramDesktop
# ... команды сборки ...
```

### 3. Облачные Mac сервисы

- **MacStadium** - аренда Mac в облаке ($99+/месяц)
- **AWS EC2 Mac instances** - Mac в AWS
- **MacInCloud** - удаленный доступ к Mac

### 4. Проверка синтаксиса (без сборки)

На Windows можно проверить синтаксис кода:

```bash
# Используйте clangd или clang-tidy для статического анализа
# (требует установки LLVM/Clang tools)
```

## Building Steps (When on Mac)

1. Configure CMake for iOS:
   ```bash
   cmake -DCMAKE_SYSTEM_NAME=iOS \
         -DCMAKE_OSX_ARCHITECTURES=arm64 \
         -DCMAKE_OSX_DEPLOYMENT_TARGET=13.0 \
         ..
   ```

2. Build the project:
   ```bash
   cmake --build . --config Release
   ```

3. Or use Xcode generator:
   ```bash
   cmake -G Xcode \
         -DCMAKE_SYSTEM_NAME=iOS \
         -DCMAKE_OSX_ARCHITECTURES=arm64 \
         ..
   ```

## Required Changes for Full iOS Support

1. **UI Framework**: Replace Qt Widgets with UIKit/SwiftUI
2. **CMakeLists.txt**: Add iOS files conditionally
3. **Xcode Project**: Create proper Xcode project structure
4. **Info.plist**: Configure iOS-specific settings
5. **Additional Modules**: Implement remaining platform modules:
   - `launcher_ios`
   - `current_geo_location_ios`
   - `overlay_widget_ios`
   - `text_recognition_ios`
   - `webauthn_ios`

## Limitations

- Qt Widgets cannot be used on iOS
- Full UI rewrite required
- Many desktop-specific features don't apply to iOS
- System tray not available on iOS
- File system access is restricted on iOS

