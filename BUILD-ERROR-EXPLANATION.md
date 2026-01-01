# 🔍 Объяснение ошибки сборки

## Проблема

Ошибка была:
```
CMake Error at CMakeLists.txt:8 (init_non_host_target):
  Unknown CMake command "init_non_host_target".
```

## Причина

CMake запускался из неправильной директории - из папки `Telegram/`, но основной `CMakeLists.txt` находится в **корне проекта**.

Функция `init_non_host_target` определена в `cmake/init_target.cmake`, который подключается из корневого `CMakeLists.txt`, но когда мы запускали из `Telegram/`, CMake не мог найти эти файлы.

## Решение

Я исправил workflow - теперь CMake запускается из **корня проекта**, где находится правильный `CMakeLists.txt`.

## Что дальше?

1. **Закоммитьте исправление:**
   ```bash
   git add .github/workflows/build-ios.yml
   git commit -m "Fix: Run CMake from project root, not Telegram subdirectory"
   git push
   ```

2. **Запустите workflow снова**

3. **Важно:** Даже после этого исправления, для полной сборки iOS версии потребуется:
   - Все зависимости (Qt для iOS, библиотеки)
   - Правильная настройка CMake toolchain для iOS
   - Переработка UI (Qt Widgets → UIKit/SwiftUI)

Но теперь, по крайней мере, CMake должен запуститься правильно и показать реальные ошибки конфигурации, а не ошибку "Unknown command".

