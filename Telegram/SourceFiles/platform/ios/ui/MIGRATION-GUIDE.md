# Migration Guide: Qt Widgets to UIKit

## Общий подход

1. **Базовые виджеты** - созданы обертки:
   - `UIWidget` - базовая замена QWidget
   - `TDIOSButton` - замена QPushButton
   - `TDIOSLabel` - замена QLabel
   - `TDIOSTextField` - замена QLineEdit
   - `TDIOSScrollView` - замена QScrollArea
   - `TDIOSStackView` - замена QVBoxLayout/QHBoxLayout

2. **Адаптеры** - создан `RpWidgetAdapter` для автоматического преобразования

3. **Систематический подход**:
   - Начать с базовых компонентов
   - Постепенно заменять виджеты в порядке зависимостей
   - Тестировать после каждого этапа

## Следующие шаги

Для полного порта нужно переписать все компоненты, использующие Qt Widgets.

