/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/ui/UILabel.h"

@implementation TDIOSLabel {
    UILabel *_nativeLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _nativeLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _nativeLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _nativeLabel.numberOfLines = 1;
        [self addSubview:_nativeLabel];
    }
    return self;
}

- (void)setText:(NSString *)text {
    _nativeLabel.text = text;
}

- (NSString *)text {
    return _nativeLabel.text;
}

- (void)setTextColor:(UIColor *)textColor {
    _nativeLabel.textColor = textColor;
}

- (UIColor *)textColor {
    return _nativeLabel.textColor;
}

- (void)setFont:(UIFont *)font {
    _nativeLabel.font = font;
}

- (UIFont *)font {
    return _nativeLabel.font;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _nativeLabel.textAlignment = textAlignment;
}

- (NSTextAlignment)textAlignment {
    return _nativeLabel.textAlignment;
}

- (void)setNumberOfLines:(NSInteger)numberOfLines {
    _nativeLabel.numberOfLines = numberOfLines;
}

- (NSInteger)numberOfLines {
    return _nativeLabel.numberOfLines;
}

@end

