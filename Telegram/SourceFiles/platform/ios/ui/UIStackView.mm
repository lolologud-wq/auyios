/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/ui/UIStackView.h"

@implementation TDIOSStackView {
    UIStackView *_nativeStackView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _nativeStackView = [[UIStackView alloc] initWithFrame:self.bounds];
        _nativeStackView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _nativeStackView.axis = UILayoutConstraintAxisVertical;
        _nativeStackView.distribution = UIStackViewDistributionFill;
        _nativeStackView.alignment = UIStackViewAlignmentFill;
        _nativeStackView.spacing = 0;
        [self addSubview:_nativeStackView];
    }
    return self;
}

- (void)setAxis:(UILayoutConstraintAxis)axis {
    _nativeStackView.axis = axis;
}

- (UILayoutConstraintAxis)axis {
    return _nativeStackView.axis;
}

- (void)setDistribution:(UIStackViewDistribution)distribution {
    _nativeStackView.distribution = distribution;
}

- (UIStackViewDistribution)distribution {
    return _nativeStackView.distribution;
}

- (void)setSpacing:(CGFloat)spacing {
    _nativeStackView.spacing = spacing;
}

- (CGFloat)spacing {
    return _nativeStackView.spacing;
}

- (void)setAlignment:(UIStackViewAlignment)alignment {
    _nativeStackView.alignment = alignment;
}

- (UIStackViewAlignment)alignment {
    return _nativeStackView.alignment;
}

- (void)addArrangedSubview:(UIView *)view {
    [_nativeStackView addArrangedSubview:view];
}

- (void)removeArrangedSubview:(UIView *)view {
    [_nativeStackView removeArrangedSubview:view];
}

- (void)insertArrangedSubview:(UIView *)view atIndex:(NSUInteger)index {
    [_nativeStackView insertArrangedSubview:view atIndex:index];
}

@end

