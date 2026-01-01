/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/ui/RpWidgetIOSBridge.h"
#include "platform/ios/ui/QtToUIKit.h"

#import <UIKit/UIKit.h>

namespace Platform {
namespace iOS {

RpWidgetIOSBridge::RpWidgetIOSBridge(QWidget *parent)
: Ui::RpWidget(parent)
, _iosView([[UIWidget alloc] initWithFrame:CGRectZero]) {
    syncGeometry();
}

RpWidgetIOSBridge::~RpWidgetIOSBridge() {
    [_iosView release];
}

void RpWidgetIOSBridge::paintEvent(QPaintEvent *e) {
    // UIKit handles painting automatically
    Ui::RpWidget::paintEvent(e);
}

void RpWidgetIOSBridge::resizeEvent(QResizeEvent *e) {
    Ui::RpWidget::resizeEvent(e);
    syncGeometry();
}

void RpWidgetIOSBridge::showEvent(QShowEvent *e) {
    Ui::RpWidget::showEvent(e);
    if (_iosView) {
        _iosView.hidden = NO;
    }
}

void RpWidgetIOSBridge::hideEvent(QHideEvent *e) {
    Ui::RpWidget::hideEvent(e);
    if (_iosView) {
        _iosView.hidden = YES;
    }
}

void RpWidgetIOSBridge::moveEvent(QMoveEvent *e) {
    Ui::RpWidget::moveEvent(e);
    syncGeometry();
}

void RpWidgetIOSBridge::syncGeometry() {
    if (_iosView) {
        QRect geometry = this->geometry();
        CGRect frame = Platform::iOS::CGRectFromQRect(geometry);
        _iosView.frame = frame;
    }
}

} // namespace iOS
} // namespace Platform

