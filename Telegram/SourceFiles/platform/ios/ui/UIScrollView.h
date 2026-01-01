/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

#import <UIKit/UIKit.h>

// UIKit scroll view that can replace QScrollArea
// Note: Renamed to avoid conflict with UIKit's UIScrollView
@interface TDIOSScrollView : UIWidget

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, assign) CGPoint contentOffset;
@property (nonatomic, assign) BOOL showsVerticalScrollIndicator;
@property (nonatomic, assign) BOOL showsHorizontalScrollIndicator;

- (void)setContentView:(UIView *)view;
- (void)scrollToTop;
- (void)scrollToBottom;

@end

