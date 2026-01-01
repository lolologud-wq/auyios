/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/ui/RpWidgetIOS.h"
#include "platform/ios/ui/QtToUIKit.h"

#import <UIKit/UIKit.h>

namespace Ui {

RpWidgetIOS::RpWidgetIOS(QWidget *parent)
: RpWidget(parent)
, _iosView([[UIWidget alloc] initWithFrame:CGRectZero]) {
    // Convert Qt widget to UIKit view
    updateIOSView();
}

RpWidgetIOS::~RpWidgetIOS() {
    [_iosView release];
}

void RpWidgetIOS::paintEvent(QPaintEvent *e) {
    // UIKit handles painting automatically
    RpWidget::paintEvent(e);
}

void RpWidgetIOS::resizeEvent(QResizeEvent *e) {
    RpWidget::resizeEvent(e);
    updateIOSView();
}

void RpWidgetIOS::showEvent(QShowEvent *e) {
    RpWidget::showEvent(e);
    [_iosView show];
}

void RpWidgetIOS::hideEvent(QHideEvent *e) {
    RpWidget::hideEvent(e);
    [_iosView hide];
}

void RpWidgetIOS::updateIOSView() {
    if (_iosView) {
        QRect geometry = this->geometry();
        CGRect frame = Platform::iOS::CGRectFromQRect(geometry);
        _iosView.frame = frame;
    }
}

} // namespace Ui

