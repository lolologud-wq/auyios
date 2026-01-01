/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/ui/UITextField.h"

@implementation TDIOSTextField {
    UITextField *_nativeTextField;
    std::function<void(NSString *)> _onTextChanged;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _nativeTextField = [[UITextField alloc] initWithFrame:self.bounds];
        _nativeTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _nativeTextField.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:_nativeTextField];
        
        [_nativeTextField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)setText:(NSString *)text {
    _nativeTextField.text = text;
}

- (NSString *)text {
    return _nativeTextField.text;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _nativeTextField.placeholder = placeholder;
}

- (NSString *)placeholder {
    return _nativeTextField.placeholder;
}

- (void)setTextColor:(UIColor *)textColor {
    _nativeTextField.textColor = textColor;
}

- (UIColor *)textColor {
    return _nativeTextField.textColor;
}

- (void)setFont:(UIFont *)font {
    _nativeTextField.font = font;
}

- (UIFont *)font {
    return _nativeTextField.font;
}

- (void)setOnTextChanged:(std::function<void(NSString *)>)callback {
    _onTextChanged = callback;
}

- (void)textChanged:(id)sender {
    if (_onTextChanged) {
        _onTextChanged(_nativeTextField.text);
    }
}

@end

