/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/ui/MainWidgetIOS.h"
#include "platform/ios/ui/DialogsWidgetIOS.h"
#include "platform/ios/ui/HistoryWidgetIOS.h"
#include "mainwidget.h"
#include "window/window_session_controller.h"

#import <UIKit/UIKit.h>

@implementation MainWidgetIOS {
    MainWidget *_mainWidget;
    UIScrollView *_scrollView;
    UIStackView *_contentStack;
}

- (instancetype)initWithMainWidget:(MainWidget *)mainWidget {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _mainWidget = mainWidget;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    
    // Create container for dialogs and history
    UIView *containerView = [[UIView alloc] init];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:containerView];
    
    // Create dialogs widget (left side on iPad, full screen on iPhone)
    DialogsWidgetIOS *dialogsWidget = [[DialogsWidgetIOS alloc] initWithController:_mainWidget->controller()];
    [self addChildViewController:dialogsWidget];
    dialogsWidget.view.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:dialogsWidget.view];
    [dialogsWidget didMoveToParentViewController:self];
    
    // Create history widget (right side on iPad, full screen on iPhone)
    // HistoryWidgetIOS *historyWidget = [[HistoryWidgetIOS alloc] initWithController:_mainWidget->controller()];
    // [self addChildViewController:historyWidget];
    // historyWidget.view.translatesAutoresizingMaskIntoConstraints = NO;
    // [containerView addSubview:historyWidget.view];
    // [historyWidget didMoveToParentViewController:self];
    
    // Setup constraints
    [NSLayoutConstraint activateConstraints:@[
        [containerView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [containerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [containerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [containerView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        
        [dialogsWidget.view.topAnchor constraintEqualToAnchor:containerView.topAnchor],
        [dialogsWidget.view.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor],
        [dialogsWidget.view.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor],
        [dialogsWidget.view.bottomAnchor constraintEqualToAnchor:containerView.bottomAnchor]
    ]];
    
    // This is a basic implementation - full UI requires:
    // - Split view for iPad (dialogs + history side by side)
    // - Navigation controller for iPhone
    // - Integration with all C++ backend components
    // - Message rendering, media handling, etc.
}

@end

