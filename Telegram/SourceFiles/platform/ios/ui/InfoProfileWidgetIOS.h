/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

#import <UIKit/UIKit.h>
#include "info/info_controller.h"

// iOS version of Info::Profile::Widget
@interface InfoProfileWidgetIOS : UIViewController

- (instancetype)initWithController:(Info::Controller *)controller;
- (void)setupUI;

@end

