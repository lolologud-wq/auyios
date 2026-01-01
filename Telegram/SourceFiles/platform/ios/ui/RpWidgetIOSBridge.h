/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

#include "ui/rp_widget.h"
#include "platform/ios/ui/UIWidget.h"

namespace Platform {
namespace iOS {

// Bridge between RpWidget (Qt-based) and UIKit
// This allows gradual migration by wrapping UIKit views in RpWidget interface
class RpWidgetIOSBridge : public Ui::RpWidget {
public:
    explicit RpWidgetIOSBridge(QWidget *parent = nullptr);
    ~RpWidgetIOSBridge();
    
    // Get the underlying UIKit view
    UIWidget *iosView() const { return _iosView; }
    
protected:
    void paintEvent(QPaintEvent *e) override;
    void resizeEvent(QResizeEvent *e) override;
    void showEvent(QShowEvent *e) override;
    void hideEvent(QHideEvent *e) override;
    void moveEvent(QMoveEvent *e) override;
    
private:
    UIWidget *_iosView;
    void syncGeometry();
};

} // namespace iOS
} // namespace Platform

