/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/ui/UIButton.h"

@implementation TDIOSButton {
    UIButton *_nativeButton;
    std::function<void()> _onClick;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _nativeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _nativeButton.frame = self.bounds;
        _nativeButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_nativeButton];
        
        [_nativeButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        self.enabled = YES;
    }
    return self;
}

- (void)setText:(NSString *)text {
    [_nativeButton setTitle:text forState:UIControlStateNormal];
}

- (NSString *)text {
    return [_nativeButton titleForState:UIControlStateNormal];
}

- (void)setTextColor:(UIColor *)color {
    [_nativeButton setTitleColor:color forState:UIControlStateNormal];
}

- (UIColor *)textColor {
    return [_nativeButton titleColorForState:UIControlStateNormal];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    _nativeButton.backgroundColor = backgroundColor;
}

- (void)setEnabled:(BOOL)enabled {
    _nativeButton.enabled = enabled;
}

- (BOOL)enabled {
    return _nativeButton.enabled;
}

- (void)setOnClick:(std::function<void()>)callback {
    _onClick = callback;
}

- (void)buttonTapped:(id)sender {
    if (_onClick) {
        _onClick();
    }
}

@end

