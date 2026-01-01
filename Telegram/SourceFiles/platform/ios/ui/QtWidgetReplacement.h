/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

// Macro system to replace Qt Widgets with UIKit equivalents
// This allows gradual migration

#ifdef Q_OS_IOS
    // Replace QWidget with UIWidget
    #define QWidget UIWidget
    #define QPushButton TDIOSButton
    #define QLabel TDIOSLabel
    #define QLineEdit TDIOSTextField
    #define QTextEdit TDIOSTextView
    #define QScrollArea TDIOSScrollView
    #define QVBoxLayout TDIOSStackView
    #define QHBoxLayout TDIOSStackView
    #define QGridLayout TDIOSStackView
    
    // Replace Qt layouts with UIStackView
    #define QVBoxLayout TDIOSStackView
    #define QHBoxLayout TDIOSStackView
    
    // Replace Qt signals/slots with blocks
    #define connect(sender, signal, receiver, slot) \
        [sender setOn##signal:^{ [receiver slot]; }]
    
    #define SIGNAL(x) On##x
    #define SLOT(x) x
    
    // Replace Qt types
    #define QPoint CGPoint
    #define QSize CGSize
    #define QRect CGRect
    #define QColor UIColor
    #define QFont UIFont
    #define QString NSString
    #define QPixmap UIImage
    
#else
    // Keep original Qt includes for other platforms
    #include <QtWidgets/QWidget>
    #include <QtWidgets/QPushButton>
    #include <QtWidgets/QLabel>
    #include <QtWidgets/QLineEdit>
    #include <QtWidgets/QTextEdit>
    #include <QtWidgets/QScrollArea>
    #include <QtWidgets/QVBoxLayout>
    #include <QtWidgets/QHBoxLayout>
    #include <QtWidgets/QGridLayout>
#endif

