/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

#import <UIKit/UIKit.h>

// UIKit label that can replace QLabel
// Note: Renamed to avoid conflict with UIKit's UILabel
@interface TDIOSLabel : UIWidget

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) NSInteger numberOfLines;

- (void)setText:(NSString *)text;
- (NSString *)text;

@end

