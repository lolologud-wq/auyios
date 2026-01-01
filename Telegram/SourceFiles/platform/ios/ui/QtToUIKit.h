/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

#import <UIKit/UIKit.h>
#include <QtCore/QObject>
#include <QtCore/QSize>
#include <QtCore/QRect>
#include <QtGui/QColor>
#include <QtGui/QFont>

// Qt to UIKit conversion helpers
namespace Platform {
namespace iOS {

inline UIColor *UIColorFromQColor(const QColor &color) {
    return [UIColor colorWithRed:color.redF() 
                          green:color.greenF() 
                           blue:color.blueF() 
                          alpha:color.alphaF()];
}

inline UIFont *UIFontFromQFont(const QFont &font) {
    CGFloat size = font.pointSizeF() > 0 ? font.pointSizeF() : 17.0;
    NSString *fontName = QString::fromUtf8(font.family().toUtf8().constData()).toNSString();
    return [UIFont fontWithName:fontName size:size] ?: [UIFont systemFontOfSize:size];
}

inline CGRect CGRectFromQRect(const QRect &rect) {
    return CGRectMake(rect.x(), rect.y(), rect.width(), rect.height());
}

inline CGSize CGSizeFromQSize(const QSize &size) {
    return CGSizeMake(size.width(), size.height());
}

inline QRect QRectFromCGRect(CGRect rect) {
    return QRect(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
}

} // namespace iOS
} // namespace Platform

