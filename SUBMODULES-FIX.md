# 🔧 Исправление проблемы с Git Submodules

## Проблема

Ошибки были:
```
CMake Error: include could not find requested file: cmake/validate_special_target.cmake
CMake Error: include could not find requested file: cmake/version.cmake
```

## Причина

Папка `cmake/` является **git submodule** (см. `.gitmodules`):
```
[submodule "cmake"]
	path = cmake
	url = https://github.com/desktop-app/cmake_helpers.git
```

По умолчанию `actions/checkout@v4` **не инициализирует submodules**, поэтому папка `cmake/` была пустой, и CMake не мог найти нужные файлы.

## Решение

Добавлен параметр `submodules: recursive` в шаг checkout:
```yaml
- name: Checkout code
  uses: actions/checkout@v4
  with:
    submodules: recursive
```

Теперь все submodules будут автоматически инициализированы и обновлены при checkout кода.

## Что делать дальше

1. **Закоммитьте исправление:**
   ```bash
   git add .github/workflows/build-ios.yml
   git commit -m "Fix: Initialize git submodules in workflow"
   git push
   ```

2. **Запустите workflow снова**

Теперь CMake должен найти все необходимые файлы из submodule `cmake/`!

## Дополнительная информация

Проект использует множество submodules:
- `cmake/` - CMake helpers (критично для сборки)
- `Telegram/lib_*` - различные библиотеки
- `Telegram/ThirdParty/*` - сторонние библиотеки

Все они теперь будут автоматически подтягиваться при сборке в GitHub Actions.

