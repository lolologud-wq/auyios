/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

// Полная миграция проекта на iOS
// Этот файл должен быть включен во все iOS сборки

#ifdef Q_OS_IOS

// 1. Включить систему автоматической замены
#include "platform/ios/ui/IOSWidgetGenerator.h"
#include "platform/ios/ui/AutoReplaceQt.h"
#include "platform/ios/ui/UIWidgetReplacement.h"

// 2. Заменить все основные виджеты
#include "platform/ios/ui/UIWidget.h"
#include "platform/ios/ui/TDIOSButton.h"
#include "platform/ios/ui/TDIOSLabel.h"
#include "platform/ios/ui/TDIOSTextField.h"
#include "platform/ios/ui/TDIOSScrollView.h"
#include "platform/ios/ui/TDIOSStackView.h"

// 3. Включить iOS версии основных компонентов
#include "platform/ios/ui/MainWidgetIOS.h"
#include "platform/ios/ui/DialogsWidgetIOS.h"
#include "platform/ios/ui/HistoryWidgetIOS.h"
#include "platform/ios/ui/RpWidgetIOSBridge.h"

// 4. Заменить namespace Ui на iOS версии
namespace Ui {
    // Все виджеты теперь используют UIKit
    using Widget = UIWidget;
    using Button = TDIOSButton;
    using Label = TDIOSLabel;
    using TextField = TDIOSTextField;
    using ScrollView = TDIOSScrollView;
    using StackView = TDIOSStackView;
}

// 5. Заменить MainWidget на iOS версию
#define MainWidget MainWidgetIOS

// 6. Заменить Dialogs::Widget на iOS версию
namespace Dialogs {
    using Widget = DialogsWidgetIOS;
}

// 7. Заменить History::Widget на iOS версию
namespace History {
    using Widget = HistoryWidgetIOS;
}

#endif // Q_OS_IOS

