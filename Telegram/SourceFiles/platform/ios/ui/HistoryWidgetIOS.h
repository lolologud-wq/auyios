/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

#import <UIKit/UIKit.h>
#include "window/window_session_controller.h"

@class HistoryWidgetIOS;

// iOS version of History::Widget
@interface HistoryWidgetIOS : UIViewController

- (instancetype)initWithController:(Window::SessionController *)controller;
- (void)setupUI;
- (void)showHistory:(Dialogs::Key)key;

@end

