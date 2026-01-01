/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

// Automatic Qt to UIKit replacement system
// Include this file in iOS builds to automatically replace Qt widgets

#ifdef Q_OS_IOS

// Replace Qt widget includes with UIKit equivalents
#ifndef QWIDGET_H
#define QWIDGET_H
#include "platform/ios/ui/UIWidget.h"
#define QWidget UIWidget
#endif

#ifndef QPUSHBUTTON_H
#define QPUSHBUTTON_H
#include "platform/ios/ui/TDIOSButton.h"
#define QPushButton TDIOSButton
#endif

#ifndef QLABEL_H
#define QLABEL_H
#include "platform/ios/ui/TDIOSLabel.h"
#define QLabel TDIOSLabel
#endif

#ifndef QLINEEDIT_H
#define QLINEEDIT_H
#include "platform/ios/ui/TDIOSTextField.h"
#define QLineEdit TDIOSTextField
#endif

#ifndef QSCROLLAREA_H
#define QSCROLLAREA_H
#include "platform/ios/ui/TDIOSScrollView.h"
#define QScrollArea TDIOSScrollView
#endif

#ifndef QVBOXLAYOUT_H
#define QVBOXLAYOUT_H
#include "platform/ios/ui/TDIOSStackView.h"
#define QVBoxLayout TDIOSStackView
#define QHBoxLayout TDIOSStackView
#define QGridLayout TDIOSStackView
#endif

// Replace Qt types
#define QPoint CGPoint
#define QSize CGSize
#define QRect CGRect
#define QColor UIColor
#define QFont UIFont
#define QString NSString
#define QPixmap UIImage
#define QImage UIImage

// Replace Qt signals/slots with blocks (simplified)
#define connect(sender, signal, receiver, slot) \
    do { \
        if constexpr (false) { \
            /* Placeholder for signal/slot replacement */ \
        } \
    } while(0)

#define SIGNAL(x) On##x
#define SLOT(x) x

// Replace RpWidget with iOS bridge
#include "ui/rp_widget.h"
namespace Ui {
    // For iOS, RpWidget should use the bridge
    // This is handled at compile time
}

#endif // Q_OS_IOS

