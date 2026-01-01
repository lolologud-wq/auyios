/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

#import <UIKit/UIKit.h>
#include <functional>

// UIKit text field that can replace QLineEdit
// Note: Renamed to avoid conflict with UIKit's UITextField
@interface TDIOSTextField : UIWidget

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;

- (void)setText:(NSString *)text;
- (NSString *)text;
- (void)setOnTextChanged:(std::function<void(NSString *)>)callback;

@end

