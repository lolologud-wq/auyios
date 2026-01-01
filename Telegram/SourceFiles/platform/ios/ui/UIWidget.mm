/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/ui/UIWidget.h"

@implementation UIWidget {
    CGSize _minimumSize;
    CGSize _maximumSize;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _minimumSize = CGSizeZero;
        _maximumSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    }
    return self;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setMinimumSize:(CGSize)size {
    _minimumSize = size;
}

- (void)setMaximumSize:(CGSize)size {
    _maximumSize = size;
}

- (void)show {
    self.hidden = NO;
}

- (void)hide {
    self.hidden = YES;
}

- (BOOL)isVisible {
    return !self.hidden && self.superview != nil;
}

- (void)update {
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize result = [super sizeThatFits:size];
    
    // Apply minimum size constraints
    if (result.width < _minimumSize.width) {
        result.width = _minimumSize.width;
    }
    if (result.height < _minimumSize.height) {
        result.height = _minimumSize.height;
    }
    
    // Apply maximum size constraints
    if (result.width > _maximumSize.width) {
        result.width = _maximumSize.width;
    }
    if (result.height > _maximumSize.height) {
        result.height = _maximumSize.height;
    }
    
    return result;
}

@end

