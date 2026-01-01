/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

#import <UIKit/UIKit.h>
#include "window/window_session_controller.h"

// iOS version of Settings::Main
@interface SettingsWidgetIOS : UIViewController <UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithController:(Window::SessionController *)controller;
- (void)setupUI;

@end

