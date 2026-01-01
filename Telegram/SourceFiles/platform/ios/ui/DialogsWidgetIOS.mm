/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/ui/DialogsWidgetIOS.h"
#include "platform/ios/ui/DialogsInnerWidgetIOS.h"
#include "dialogs/dialogs_widget.h"
#include "window/window_session_controller.h"

#import <UIKit/UIKit.h>

@implementation DialogsWidgetIOS {
    Window::SessionController *_controller;
    DialogsInnerWidgetIOS *_innerWidget;
    UISearchBar *_searchBar;
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
    
    // Create search bar
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.placeholder = @"Search";
    _searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_searchBar];
    
    // Create inner widget (handles dialog list)
    _innerWidget = [[DialogsInnerWidgetIOS alloc] initWithController:_controller];
    [self addChildViewController:_innerWidget];
    _innerWidget.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_innerWidget.view];
    [_innerWidget didMoveToParentViewController:self];
    
    // Setup constraints
    [NSLayoutConstraint activateConstraints:@[
        [_searchBar.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [_searchBar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [_searchBar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        
        [_innerWidget.view.topAnchor constraintEqualToAnchor:_searchBar.bottomAnchor],
        [_innerWidget.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [_innerWidget.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [_innerWidget.view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

- (void)updateDialogs {
    // Update inner widget
    [_innerWidget updateDialogs];
}

@end

