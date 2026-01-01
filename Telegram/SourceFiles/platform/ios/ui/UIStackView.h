/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

#import <UIKit/UIKit.h>

// UIKit stack view that can replace QVBoxLayout/QHBoxLayout
// Note: Renamed to avoid conflict with UIKit's UIStackView
@interface TDIOSStackView : UIWidget

@property (nonatomic, assign) UILayoutConstraintAxis axis;
@property (nonatomic, assign) UIStackViewDistribution distribution;
@property (nonatomic, assign) CGFloat spacing;
@property (nonatomic, assign) UIStackViewAlignment alignment;

- (void)addArrangedSubview:(UIView *)view;
- (void)removeArrangedSubview:(UIView *)view;
- (void)insertArrangedSubview:(UIView *)view atIndex:(NSUInteger)index;

@end

