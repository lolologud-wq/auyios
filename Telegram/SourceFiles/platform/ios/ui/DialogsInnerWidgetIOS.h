/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

#import <UIKit/UIKit.h>
#include "dialogs/dialogs_inner_widget.h"
#include "window/window_session_controller.h"

// iOS version of DialogsInnerWidget using UITableView
@interface DialogsInnerWidgetIOS : UIViewController <UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithController:(Window::SessionController *)controller;
- (void)setupUI;
- (void)updateDialogs;

@end

