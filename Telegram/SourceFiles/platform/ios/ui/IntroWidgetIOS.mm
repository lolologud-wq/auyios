/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/ui/IntroWidgetIOS.h"
#include "intro/intro_widget.h"
#include "main/main_account.h"

#import <UIKit/UIKit.h>

@implementation IntroWidgetIOS {
    Main::Account *_account;
    UIScrollView *_scrollView;
    UIStackView *_contentStack;
}

- (instancetype)initWithAccount:(Main::Account *)account {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _account = account;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    
    // Create scroll view
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_scrollView];
    
    // Create content stack
    _contentStack = [[UIStackView alloc] init];
    _contentStack.axis = UILayoutConstraintAxisVertical;
    _contentStack.distribution = UIStackViewDistributionFill;
    _contentStack.alignment = UIStackViewAlignmentFill;
    _contentStack.spacing = 20;
    _contentStack.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView addSubview:_contentStack];
    
    // Setup constraints
    [NSLayoutConstraint activateConstraints:@[
        [_scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [_scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [_scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [_scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        
        [_contentStack.topAnchor constraintEqualToAnchor:_scrollView.topAnchor constant:20],
        [_contentStack.leadingAnchor constraintEqualToAnchor:_scrollView.leadingAnchor constant:20],
        [_contentStack.trailingAnchor constraintEqualToAnchor:_scrollView.trailingAnchor constant:-20],
        [_contentStack.bottomAnchor constraintEqualToAnchor:_scrollView.bottomAnchor constant:-20],
        [_contentStack.widthAnchor constraintEqualToAnchor:_scrollView.widthAnchor constant:-40]
    ]];
    
    // Placeholder UI - full implementation requires all intro steps
}

@end

