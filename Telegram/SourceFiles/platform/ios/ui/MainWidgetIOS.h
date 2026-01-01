/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

#import <UIKit/UIKit.h>
#include "mainwidget.h"

// iOS version of MainWidget using UIKit
@interface MainWidgetIOS : UIViewController

- (instancetype)initWithMainWidget:(MainWidget *)mainWidget;
- (void)setupUI;

@end

