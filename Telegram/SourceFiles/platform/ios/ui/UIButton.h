/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

#import <UIKit/UIKit.h>
#include <functional>

// UIKit button that can replace QPushButton
// Note: Renamed to avoid conflict with UIKit's UIButton
@interface TDIOSButton : UIWidget

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, assign) BOOL enabled;

- (void)setText:(NSString *)text;
- (void)setTextColor:(UIColor *)color;
- (void)setOnClick:(std::function<void()>)callback;

@end

