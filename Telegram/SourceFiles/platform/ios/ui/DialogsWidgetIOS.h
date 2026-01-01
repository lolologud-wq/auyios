/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

#import <UIKit/UIKit.h>
#include "dialogs/dialogs_key.h"
#include "window/window_session_controller.h"

@class DialogsWidgetIOS;

// iOS version of Dialogs::Widget
@interface DialogsWidgetIOS : UIViewController

- (instancetype)initWithController:(Window::SessionController *)controller;
- (void)setupUI;
- (void)updateDialogs;

@end

