/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

#import <UIKit/UIKit.h>

// iOS version of Ui::BoxContent - modal dialog
@interface BoxIOS : UIViewController

- (instancetype)initWithTitle:(NSString *)title;
- (void)addButton:(NSString *)title action:(void(^)(void))action;
- (void)addCancelButton;

@end

