/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

#import <UIKit/UIKit.h>

// Base UIKit view that can replace QWidget
@interface UIWidget : UIView

- (instancetype)initWithFrame:(CGRect)frame;
- (void)setSize:(CGSize)size;
- (CGSize)size;
- (void)setMinimumSize:(CGSize)size;
- (void)setMaximumSize:(CGSize)size;
- (void)show;
- (void)hide;
- (BOOL)isVisible;
- (void)update;

@end

