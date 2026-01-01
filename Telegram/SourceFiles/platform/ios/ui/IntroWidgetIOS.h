/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

#import <UIKit/UIKit.h>
#include "intro/intro_widget.h"

// iOS version of Intro::Widget
@interface IntroWidgetIOS : UIViewController

- (instancetype)initWithAccount:(Main::Account *)account;
- (void)setupUI;

@end

