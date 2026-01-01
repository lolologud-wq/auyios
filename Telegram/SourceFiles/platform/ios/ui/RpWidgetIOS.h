/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

#include "ui/rp_widget.h"
#include "platform/ios/ui/UIWidget.h"

namespace Ui {

// iOS implementation of RpWidget using UIKit
class RpWidgetIOS : public RpWidget {
public:
    explicit RpWidgetIOS(QWidget *parent = nullptr);
    ~RpWidgetIOS();

protected:
    void paintEvent(QPaintEvent *e) override;
    void resizeEvent(QResizeEvent *e) override;
    void showEvent(QShowEvent *e) override;
    void hideEvent(QHideEvent *e) override;
    
private:
    UIWidget *_iosView;
    void updateIOSView();
};

} // namespace Ui

