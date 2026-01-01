/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/ui/BoxIOS.h"

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation BoxIOS {
    UIStackView *_contentStack;
    UIStackView *_buttonStack;
    NSMutableArray *_actions;
}

- (instancetype)initWithTitle:(NSString *)title {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.title = title;
        _actions = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    
    // Create scroll view for content
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:scrollView];
    
    // Create content stack
    _contentStack = [[UIStackView alloc] init];
    _contentStack.axis = UILayoutConstraintAxisVertical;
    _contentStack.distribution = UIStackViewDistributionFill;
    _contentStack.alignment = UIStackViewAlignmentFill;
    _contentStack.spacing = 16;
    _contentStack.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addSubview:_contentStack];
    
    // Create button stack
    _buttonStack = [[UIStackView alloc] init];
    _buttonStack.axis = UILayoutConstraintAxisVertical;
    _buttonStack.distribution = UIStackViewDistributionFillEqually;
    _buttonStack.alignment = UIStackViewAlignmentFill;
    _buttonStack.spacing = 8;
    _buttonStack.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_buttonStack];
    
    // Setup constraints
    [NSLayoutConstraint activateConstraints:@[
        [scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20],
        [scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20],
        [scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20],
        [scrollView.bottomAnchor constraintEqualToAnchor:_buttonStack.topAnchor constant:-20],
        
        [_contentStack.topAnchor constraintEqualToAnchor:scrollView.topAnchor],
        [_contentStack.leadingAnchor constraintEqualToAnchor:scrollView.leadingAnchor],
        [_contentStack.trailingAnchor constraintEqualToAnchor:scrollView.trailingAnchor],
        [_contentStack.bottomAnchor constraintEqualToAnchor:scrollView.bottomAnchor],
        [_contentStack.widthAnchor constraintEqualToAnchor:scrollView.widthAnchor],
        
        [_buttonStack.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20],
        [_buttonStack.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20],
        [_buttonStack.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-20],
        [_buttonStack.heightAnchor constraintGreaterThanOrEqualToConstant:44]
    ]];
}

- (void)addButton:(NSString *)title action:(void(^)(void))action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor secondarySystemBackgroundColor];
    button.layer.cornerRadius = 8;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (action) {
        void(^actionCopy)(void) = [action copy];
        [_actions addObject:actionCopy];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        objc_setAssociatedObject(button, @"action", actionCopy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    [_buttonStack addArrangedSubview:button];
    [button.heightAnchor constraintEqualToConstant:44].active = YES;
}

- (void)buttonTapped:(UIButton *)sender {
    void(^action)(void) = objc_getAssociatedObject(sender, @"action");
    if (action) {
        action();
    }
}

- (void)addCancelButton {
    [self addButton:@"Cancel" action:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end

