/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/ui/TabbedSelectorIOS.h"
#include "chat_helpers/tabbed_selector.h"
#include "window/window_session_controller.h"

#import <UIKit/UIKit.h>

@implementation TabbedSelectorIOS {
    Window::SessionController *_controller;
    UISegmentedControl *_tabControl;
    UIScrollView *_contentScrollView;
    UIView *_stickersView;
    UIView *_gifsView;
    UIView *_emojiView;
}

- (instancetype)initWithController:(Window::SessionController *)controller {
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
    
    // Create tab control
    _tabControl = [[UISegmentedControl alloc] initWithItems:@[@"Stickers", @"GIFs", @"Emoji"]];
    _tabControl.selectedSegmentIndex = 0;
    [_tabControl addTarget:self action:@selector(tabChanged:) forControlEvents:UIControlEventValueChanged];
    _tabControl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_tabControl];
    
    // Create content scroll view
    _contentScrollView = [[UIScrollView alloc] init];
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_contentScrollView];
    
    // Create stickers view
    _stickersView = [[UIView alloc] init];
    _stickersView.backgroundColor = [UIColor systemBackgroundColor];
    _stickersView.translatesAutoresizingMaskIntoConstraints = NO;
    [_contentScrollView addSubview:_stickersView];
    
    // Create GIFs view
    _gifsView = [[UIView alloc] init];
    _gifsView.backgroundColor = [UIColor systemBackgroundColor];
    _gifsView.translatesAutoresizingMaskIntoConstraints = NO;
    [_contentScrollView addSubview:_gifsView];
    
    // Create emoji view
    _emojiView = [[UIView alloc] init];
    _emojiView.backgroundColor = [UIColor systemBackgroundColor];
    _emojiView.translatesAutoresizingMaskIntoConstraints = NO;
    [_contentScrollView addSubview:_emojiView];
    
    // Setup constraints
    [NSLayoutConstraint activateConstraints:@[
        [_tabControl.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:8],
        [_tabControl.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20],
        [_tabControl.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20],
        
        [_contentScrollView.topAnchor constraintEqualToAnchor:_tabControl.bottomAnchor constant:8],
        [_contentScrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [_contentScrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [_contentScrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        
        [_stickersView.topAnchor constraintEqualToAnchor:_contentScrollView.topAnchor],
        [_stickersView.leadingAnchor constraintEqualToAnchor:_contentScrollView.leadingAnchor],
        [_stickersView.widthAnchor constraintEqualToAnchor:_contentScrollView.widthAnchor],
        [_stickersView.heightAnchor constraintEqualToAnchor:_contentScrollView.heightAnchor],
        
        [_gifsView.topAnchor constraintEqualToAnchor:_contentScrollView.topAnchor],
        [_gifsView.leadingAnchor constraintEqualToAnchor:_stickersView.trailingAnchor],
        [_gifsView.widthAnchor constraintEqualToAnchor:_contentScrollView.widthAnchor],
        [_gifsView.heightAnchor constraintEqualToAnchor:_contentScrollView.heightAnchor],
        
        [_emojiView.topAnchor constraintEqualToAnchor:_contentScrollView.topAnchor],
        [_emojiView.leadingAnchor constraintEqualToAnchor:_gifsView.trailingAnchor],
        [_emojiView.trailingAnchor constraintEqualToAnchor:_contentScrollView.trailingAnchor],
        [_emojiView.widthAnchor constraintEqualToAnchor:_contentScrollView.widthAnchor],
        [_emojiView.heightAnchor constraintEqualToAnchor:_contentScrollView.heightAnchor]
    ]];
}

- (void)tabChanged:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    CGFloat offset = index * _contentScrollView.bounds.size.width;
    [_contentScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
}

- (void)showStickers {
    _tabControl.selectedSegmentIndex = 0;
    [self tabChanged:_tabControl];
}

- (void)showGifs {
    _tabControl.selectedSegmentIndex = 1;
    [self tabChanged:_tabControl];
}

- (void)showEmoji {
    _tabControl.selectedSegmentIndex = 2;
    [self tabChanged:_tabControl];
}

@end

