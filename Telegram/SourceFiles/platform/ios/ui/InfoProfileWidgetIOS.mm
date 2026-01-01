/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/ui/InfoProfileWidgetIOS.h"
#include "info/profile/info_profile_widget.h"
#include "info/info_controller.h"

#import <UIKit/UIKit.h>

@implementation InfoProfileWidgetIOS {
    Info::Controller *_controller;
    UIScrollView *_scrollView;
    UIStackView *_contentStack;
    UIImageView *_avatarView;
    UILabel *_nameLabel;
    UILabel *_statusLabel;
}

- (instancetype)initWithController:(Info::Controller *)controller {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _controller = controller;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"Profile";
    
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
    
    // Create avatar view
    _avatarView = [[UIImageView alloc] init];
    _avatarView.layer.cornerRadius = 50;
    _avatarView.clipsToBounds = YES;
    _avatarView.backgroundColor = [UIColor systemGrayColor];
    _avatarView.translatesAutoresizingMaskIntoConstraints = NO;
    [_contentStack addArrangedSubview:_avatarView];
    
    // Create name label
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont boldSystemFontOfSize:24];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_contentStack addArrangedSubview:_nameLabel];
    
    // Create status label
    _statusLabel = [[UILabel alloc] init];
    _statusLabel.font = [UIFont systemFontOfSize:16];
    _statusLabel.textColor = [UIColor secondaryLabelColor];
    _statusLabel.textAlignment = NSTextAlignmentCenter;
    _statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_contentStack addArrangedSubview:_statusLabel];
    
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
        [_contentStack.widthAnchor constraintEqualToAnchor:_scrollView.widthAnchor constant:-40],
        
        [_avatarView.widthAnchor constraintEqualToConstant:100],
        [_avatarView.heightAnchor constraintEqualToConstant:100]
    ]];
}

@end

