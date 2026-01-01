/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/ui/UIScrollView.h"

@implementation TDIOSScrollView {
    UIScrollView *_nativeScrollView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _nativeScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _nativeScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _nativeScrollView.showsVerticalScrollIndicator = YES;
        _nativeScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_nativeScrollView];
    }
    return self;
}

- (void)setContentView:(UIView *)contentView {
    [_nativeScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (contentView) {
        [_nativeScrollView addSubview:contentView];
        _nativeScrollView.contentSize = contentView.frame.size;
    }
}

- (UIView *)contentView {
    return _nativeScrollView.subviews.firstObject;
}

- (void)setContentSize:(CGSize)contentSize {
    _nativeScrollView.contentSize = contentSize;
}

- (CGSize)contentSize {
    return _nativeScrollView.contentSize;
}

- (void)setContentOffset:(CGPoint)contentOffset {
    _nativeScrollView.contentOffset = contentOffset;
}

- (CGPoint)contentOffset {
    return _nativeScrollView.contentOffset;
}

- (void)setShowsVerticalScrollIndicator:(BOOL)showsVerticalScrollIndicator {
    _nativeScrollView.showsVerticalScrollIndicator = showsVerticalScrollIndicator;
}

- (BOOL)showsVerticalScrollIndicator {
    return _nativeScrollView.showsVerticalScrollIndicator;
}

- (void)setShowsHorizontalScrollIndicator:(BOOL)showsHorizontalScrollIndicator {
    _nativeScrollView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator;
}

- (BOOL)showsHorizontalScrollIndicator {
    return _nativeScrollView.showsHorizontalScrollIndicator;
}

- (void)scrollToTop {
    [_nativeScrollView setContentOffset:CGPointZero animated:YES];
}

- (void)scrollToBottom {
    CGPoint bottomOffset = CGPointMake(0, _nativeScrollView.contentSize.height - _nativeScrollView.bounds.size.height);
    if (bottomOffset.y < 0) bottomOffset.y = 0;
    [_nativeScrollView setContentOffset:bottomOffset animated:YES];
}

@end

