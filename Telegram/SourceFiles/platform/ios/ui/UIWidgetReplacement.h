/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

// iOS-specific widget replacements
// This file provides UIKit equivalents for Qt widgets

#ifdef Q_OS_IOS
    #include "platform/ios/ui/UIWidget.h"
    #include "platform/ios/ui/TDIOSButton.h"
    #include "platform/ios/ui/TDIOSLabel.h"
    #include "platform/ios/ui/TDIOSTextField.h"
    #include "platform/ios/ui/TDIOSScrollView.h"
    #include "platform/ios/ui/TDIOSStackView.h"
    
    // Type aliases for easier migration
    namespace Ui {
        using Widget = UIWidget;
        using Button = TDIOSButton;
        using Label = TDIOSLabel;
        using TextField = TDIOSTextField;
        using ScrollView = TDIOSScrollView;
        using StackView = TDIOSStackView;
    }
#else
    // Original Qt includes for other platforms
    #include <QtWidgets/QWidget>
    #include <QtWidgets/QPushButton>
    #include <QtWidgets/QLabel>
    #include <QtWidgets/QLineEdit>
    #include <QtWidgets/QScrollArea>
    #include <QtWidgets/QVBoxLayout>
    #include <QtWidgets/QHBoxLayout>
#endif

