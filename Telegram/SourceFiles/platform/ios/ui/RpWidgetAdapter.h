/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

#include "ui/widgets/rp_widget.h"
#include "platform/ios/ui/UIWidget.h"

namespace Platform {
namespace iOS {

// Adapter to convert RpWidget to UIWidget for iOS
class RpWidgetAdapter {
public:
    static UIWidget *CreateFromRpWidget(not_null<Ui::RpWidget*> widget);
    static void UpdateLayout(UIWidget *iosWidget, not_null<Ui::RpWidget*> qtWidget);
    
private:
    static UIWidget *CreateWidgetForType(const QString &typeName);
};

} // namespace iOS
} // namespace Platform

