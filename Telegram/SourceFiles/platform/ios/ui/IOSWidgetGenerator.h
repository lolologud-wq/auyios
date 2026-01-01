/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

// iOS Widget Generator - автоматическая система переработки Qt виджетов в UIKit
// Используется для массовой конвертации всех компонентов проекта

#ifdef Q_OS_IOS

// Макросы для автоматической замены Qt виджетов на UIKit
#define QT_WIDGET_TO_UIKIT(QtWidget, UIKitClass) \
    using QtWidget = UIKitClass;

// Автоматическая замена базовых виджетов
QT_WIDGET_TO_UIKIT(QWidget, UIWidget)
QT_WIDGET_TO_UIKIT(QPushButton, TDIOSButton)
QT_WIDGET_TO_UIKIT(QLabel, TDIOSLabel)
QT_WIDGET_TO_UIKIT(QLineEdit, TDIOSTextField)
QT_WIDGET_TO_UIKIT(QTextEdit, TDIOSTextView)
QT_WIDGET_TO_UIKIT(QScrollArea, TDIOSScrollView)
QT_WIDGET_TO_UIKIT(QVBoxLayout, TDIOSStackView)
QT_WIDGET_TO_UIKIT(QHBoxLayout, TDIOSStackView)
QT_WIDGET_TO_UIKIT(QGridLayout, TDIOSStackView)
QT_WIDGET_TO_UIKIT(QTableView, UITableView)
QT_WIDGET_TO_UIKIT(QListView, UICollectionView)

// Замена Qt типов на iOS типы
#define QPoint CGPoint
#define QSize CGSize
#define QRect CGRect
#define QColor UIColor
#define QFont UIFont
#define QString NSString
#define QPixmap UIImage
#define QImage UIImage
#define QByteArray NSData
#define QVariant id

// Замена сигналов/слотов на блоки
#define connect(sender, signal, receiver, slot) \
    [sender set##signal##Block:^{ [receiver slot]; }]

#define SIGNAL(x) On##x
#define SLOT(x) x

// Замена событий
#define QPaintEvent UIEvent
#define QResizeEvent UIEvent
#define QShowEvent UIEvent
#define QHideEvent UIEvent
#define QMoveEvent UIEvent
#define QMouseEvent UIEvent
#define QKeyEvent UIEvent

#endif // Q_OS_IOS

